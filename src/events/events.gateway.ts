import { WebSocketGateway, WebSocketServer, SubscribeMessage, MessageBody, ConnectedSocket, OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';

@WebSocketGateway({
  cors: {
    origin: process.env.CORS_ORIGIN || 'http://localhost:5173',
    credentials: true,
  },
})
export class EventsGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private readonly logger = new Logger(EventsGateway.name);

  constructor(
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  handleConnection(client: Socket) {
    try {
      const token =
        client.handshake.auth?.token ||
        client.handshake.headers?.authorization?.split(' ')[1];

      if (!token) {
        this.logger.warn(`WS connection rejected (no token): ${client.id}`);
        client.emit('error', { message: 'Authentication required' });
        client.disconnect();
        return;
      }

      const payload = this.jwtService.verify(token, {
        secret: this.configService.get<string>('JWT_SECRET'),
      });

      client.data.userId = payload.sub;
      client.data.email = payload.email;
      client.data.role = payload.role;

      // Auto-join user room
      const room = `user:${payload.sub}`;
      client.join(room);

      this.logger.log(`WS connected: ${client.id} (user: ${payload.email})`);
    } catch {
      this.logger.warn(`WS connection rejected (invalid token): ${client.id}`);
      client.emit('error', { message: 'Invalid token' });
      client.disconnect();
    }
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`WS disconnected: ${client.id} (user: ${client.data?.email || 'unknown'})`);
  }

  @SubscribeMessage('join')
  handleJoin(@MessageBody() data: { userId: string }, @ConnectedSocket() client: Socket) {
    // Verify the user can only join their own room
    if (client.data.userId && client.data.userId !== data.userId) {
      this.logger.warn(`User ${client.data.userId} tried to join room of user ${data.userId}`);
      return;
    }
    const room = `user:${data.userId}`;
    client.join(room);
    this.logger.log(`Client ${client.id} joined room ${room}`);
  }

  // ── Broadcast events (all clients) ──

  emitMatchResult(matchId: string, localResult: number, visitingResult: number) {
    this.server.emit('match.result', { matchId, localResult, visitingResult });
  }

  emitScoreUpdated(matchId: string) {
    this.server.emit('score.updated', { matchId });
  }

  emitRankingUpdated() {
    this.server.emit('ranking.updated', { timestamp: new Date().toISOString() });
  }

  // ── User-specific events (room-based) ──

  emitPredictionSaved(userId: string, matchId: string, localScore: number, visitorScore: number) {
    this.server.to(`user:${userId}`).emit('prediction.saved', { userId, matchId, localScore, visitorScore });
  }

  /** Broadcast to all clients that a match prediction was updated (for live modal viewing) */
  emitMatchPredictionUpdated(matchId: string) {
    this.server.emit('match.prediction.updated', { matchId });
  }

  emitProfileUpdated(userId: string, profileImage: string) {
    this.server.to(`user:${userId}`).emit('profile.updated', { userId, profileImage });
  }

  emitForceLogout(userId: string) {
    this.logger.log(`Emitting force.logout to room user:${userId}`);
    this.server.to(`user:${userId}`).emit('force.logout', { userId });
  }
}
