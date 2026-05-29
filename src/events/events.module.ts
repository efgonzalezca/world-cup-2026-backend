import { Module } from '@nestjs/common';
import { EventsGateway } from './events.gateway';
import { UsersChangesListenerService } from './users-changes-listener.service';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [AuthModule],
  providers: [EventsGateway, UsersChangesListenerService],
  exports: [EventsGateway],
})
export class EventsModule {}
