import { Injectable, Logger, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Client } from 'pg';
import { EventsGateway } from './events.gateway';
import { CacheService } from '../common/cache/cache.service';

interface UserChangedPayload {
  op: 'INSERT' | 'UPDATE' | 'DELETE';
  id: string;
  is_active: boolean;
}

const BACKOFF_MS = [1_000, 2_000, 5_000, 10_000, 30_000];

@Injectable()
export class UsersChangesListenerService implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(UsersChangesListenerService.name);
  private client: Client | null = null;
  private reconnectAttempt = 0;
  private reconnectTimer: NodeJS.Timeout | null = null;
  private stopped = false;

  constructor(
    private readonly configService: ConfigService,
    private readonly eventsGateway: EventsGateway,
    private readonly cacheService: CacheService,
  ) {}

  async onModuleInit(): Promise<void> {
    this.stopped = false;
    await this.connect();
  }

  async onModuleDestroy(): Promise<void> {
    this.stopped = true;
    if (this.reconnectTimer) {
      clearTimeout(this.reconnectTimer);
      this.reconnectTimer = null;
    }
    if (this.client) {
      try {
        await this.client.end();
      } catch (err) {
        this.logger.warn(`Error closing pg listener client: ${(err as Error).message}`);
      }
      this.client = null;
    }
  }

  private async connect(): Promise<void> {
    if (this.stopped) return;

    const client = new Client({
      host: this.configService.get<string>('DB_HOST'),
      port: parseInt(this.configService.get<string>('DB_PORT') ?? '5432', 10),
      user: this.configService.get<string>('DB_USERNAME'),
      password: this.configService.get<string>('DB_PASSWORD'),
      database: this.configService.get<string>('DB_DATABASE'),
    });

    client.on('error', (err) => {
      this.logger.error(`pg listener client error: ${err.message}`);
      this.scheduleReconnect();
    });

    client.on('end', () => {
      this.logger.warn('pg listener client connection ended');
      this.scheduleReconnect();
    });

    client.on('notification', (msg) => {
      if (msg.channel !== 'user_changed' || !msg.payload) return;
      this.handlePayload(msg.payload).catch((err) =>
        this.logger.error(`Error handling user_changed notification: ${(err as Error).message}`),
      );
    });

    try {
      await client.connect();
      await client.query('LISTEN user_changed');
      this.client = client;
      this.reconnectAttempt = 0;
      this.logger.log('Listening on PostgreSQL channel "user_changed"');
    } catch (err) {
      this.logger.error(`Failed to connect pg listener: ${(err as Error).message}`);
      try {
        await client.end();
      } catch {
        /* ignore */
      }
      this.scheduleReconnect();
    }
  }

  private scheduleReconnect(): void {
    if (this.stopped || this.reconnectTimer) return;
    this.client = null;
    const delay = BACKOFF_MS[Math.min(this.reconnectAttempt, BACKOFF_MS.length - 1)];
    this.reconnectAttempt += 1;
    this.logger.warn(`Reconnecting pg listener in ${delay}ms (attempt ${this.reconnectAttempt})`);
    this.reconnectTimer = setTimeout(() => {
      this.reconnectTimer = null;
      void this.connect();
    }, delay);
  }

  private async handlePayload(raw: string): Promise<void> {
    let payload: UserChangedPayload;
    try {
      payload = JSON.parse(raw) as UserChangedPayload;
    } catch (err) {
      this.logger.error(`Invalid user_changed payload: ${(err as Error).message}`);
      return;
    }

    this.logger.log(`user_changed received: op=${payload.op} id=${payload.id} is_active=${payload.is_active}`);

    await this.cacheService.delByPrefix('ranking:');

    if (payload.op === 'DELETE' || payload.is_active === false) {
      const reason = payload.op === 'DELETE' ? 'account_deleted' : 'account_deactivated';
      this.eventsGateway.emitForceLogout(payload.id, reason);
      this.eventsGateway.disconnectUserSockets(payload.id);
    }
  }
}