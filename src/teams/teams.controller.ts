import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { TeamsService } from './teams.service';

@Controller('teams')
@UseGuards(AuthGuard('jwt'))
export class TeamsController {
  constructor(private readonly teamsService: TeamsService) {}

  @Get()
  async findAll(@Query('group') groupCode?: string) {
    return this.teamsService.findAll(groupCode);
  }

  @Get('groups')
  async findGroups() {
    return this.teamsService.findGroups();
  }
}
