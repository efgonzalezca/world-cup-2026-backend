import { Controller, Get, Patch, Param, Body, Query, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { MatchesService } from './matches.service';
import { UpdateResultDto } from './dto/update-result.dto';
import { Roles } from '../common/decorators/roles.decorator';
import { RolesGuard } from '../common/guards/roles.guard';

@Controller('matches')
@UseGuards(AuthGuard('jwt'))
export class MatchesController {
  constructor(private readonly matchesService: MatchesService) {}

  @Get()
  async findAll(@Query('phase') phase?: string) {
    return this.matchesService.findAll(phase);
  }

  @Patch(':matchId')
  @UseGuards(RolesGuard)
  @Roles('admin')
  async updateResult(
    @Param('matchId') matchId: string,
    @Body() updateResultDto: UpdateResultDto,
  ) {
    return this.matchesService.updateResult(matchId, updateResultDto);
  }
}
