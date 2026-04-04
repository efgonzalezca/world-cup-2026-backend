import { WebSocketGateway, WebSocketServer, SubscribeMessage, MessageBody, ConnectedSocket, OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Logger } from '@nestjs/common';

@WebSocketGateway({
  cors: {
    origin: '*',
    credentials: true,
  },
})
export class EventsGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  private readonly logger = new Logger(EventsGateway.name);

  handleConnection(client: Socket) {
    this.logger.log(`Client connected: ${client.id}`);
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  /** Client joins their user-specific room */
  @SubscribeMessage('join')
  handleJoin(@MessageBody() data: { userId: string }, @ConnectedSocket() client: Socket) {
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
