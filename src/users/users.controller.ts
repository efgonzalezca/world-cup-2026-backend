import { Controller, Get, Post, Patch, Body, Param, UseGuards, Request, BadRequestException } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UpdatePredictionDto } from './dto/update-prediction.dto';
import { ResetPasswordDto } from './dto/reset-password.dto';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  async register(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  @Get()
  @UseGuards(AuthGuard('jwt'))
  async getRanking() {
    return this.usersService.getRanking();
  }

  @Get(':userId/matches/all')
  @UseGuards(AuthGuard('jwt'))
  async getUserPredictions(@Param('userId') userId: string, @Request() req) {
    return this.usersService.getUserPredictions(userId, req.user.id);
  }

  @Get('matches/:matchId')
  @UseGuards(AuthGuard('jwt'))
  async getMatchPredictions(@Param('matchId') matchId: string) {
    return this.usersService.getMatchPredictions(matchId);
  }

  @Patch(':userId')
  @UseGuards(AuthGuard('jwt'))
  async updateUser(
    @Param('userId') userId: string,
    @Body() updateUserDto: UpdateUserDto,
    @Request() req,
  ) {
    return this.usersService.updateUser(userId, req.user.id, updateUserDto);
  }

  @Post(':userId/avatar')
  @UseGuards(AuthGuard('jwt'))
  async uploadAvatar(
    @Param('userId') userId: string,
    @Body() body: { image: string },
    @Request() req,
  ) {
    if (!body.image) throw new BadRequestException('No se envio imagen');

    // Validate base64 data URI format with strict MIME type
    const mimeMatch = body.image.match(/^data:image\/(png|jpeg|jpg|gif|webp);base64,/);
    if (!mimeMatch) {
      throw new BadRequestException('Formato de imagen invalido. Solo se permiten: png, jpeg, jpg, gif, webp');
    }

    // Reject SVG (can contain embedded scripts)
    if (body.image.includes('image/svg')) {
      throw new BadRequestException('Formato SVG no permitido');
    }

    // Validate size (~1MB in base64 ≈ 1.37MB string)
    if (body.image.length > 1.5 * 1024 * 1024) {
      throw new BadRequestException('La imagen no puede superar 1MB');
    }

    // Check base64 payload doesn't contain executable content
    const base64Data = body.image.split(',')[1];
    if (!base64Data) {
      throw new BadRequestException('Datos de imagen invalidos');
    }

    const decoded = Buffer.from(base64Data, 'base64').toString('utf8').toLowerCase();
    const dangerousPatterns = ['<script', 'javascript:', 'onerror', 'onload', 'eval(', '<svg', '<?xml'];
    if (dangerousPatterns.some((pattern) => decoded.includes(pattern))) {
      throw new BadRequestException('La imagen contiene contenido no permitido');
    }

    return this.usersService.updateProfileImage(userId, req.user.id, body.image);
  }

  @Post('reset-password')
  async requestPasswordReset(@Body() resetPasswordDto: ResetPasswordDto) {
    return this.usersService.requestPasswordReset(resetPasswordDto.email);
  }

  @Patch(':userId/matches/:matchId')
  @UseGuards(AuthGuard('jwt'))
  async updatePrediction(
    @Param('userId') userId: string,
    @Param('matchId') matchId: string,
    @Body() updatePredictionDto: UpdatePredictionDto,
    @Request() req,
  ) {
    return this.usersService.updatePrediction(userId, matchId, req.user.id, updatePredictionDto);
  }
}
