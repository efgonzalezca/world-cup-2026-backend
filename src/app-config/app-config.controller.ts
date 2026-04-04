import { Controller, Get, Patch, Body, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from '../common/decorators/roles.decorator';
import { RolesGuard } from '../common/guards/roles.guard';
import { AppConfigService } from './app-config.service';

@Controller('config')
export class AppConfigController {
  constructor(private readonly configService: AppConfigService) {}

  /** Public: anyone can read the podium deadline */
  @Get('podium-deadline')
  async getPodiumDeadline() {
    const deadline = await this.configService.getPodiumDeadline();
    return { podium_deadline: deadline };
  }

  /** Admin only: update a config value */
  @Patch()
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles('admin')
  async updateConfig(@Body() body: { key: string; value: string; description?: string }) {
    const config = await this.configService.set(body.key, body.value, body.description);
    return config;
  }

  /** Admin only: list all config values */
  @Get()
  @UseGuards(AuthGuard('jwt'), RolesGuard)
  @Roles('admin')
  async getAll() {
    return this.configService.getAll();
  }
}
