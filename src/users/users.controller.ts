import { Controller, Get, Post, Patch, Body, Param, Query, UseGuards, Request, BadRequestException } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Throttle } from '@nestjs/throttler';
import { promises as fs } from 'fs';
import * as path from 'path';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { UpdatePredictionDto } from './dto/update-prediction.dto';
import { ResetPasswordDto } from './dto/reset-password.dto';

const IMAGE_MAGIC_BYTES: Record<string, number[][]> = {
  png: [[0x89, 0x50, 0x4E, 0x47]],
  jpg: [[0xFF, 0xD8, 0xFF]],
  jpeg: [[0xFF, 0xD8, 0xFF]],
  gif: [[0x47, 0x49, 0x46, 0x38]],
  webp: [[0x52, 0x49, 0x46, 0x46]],
};

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  async register(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  @Get()
  @UseGuards(AuthGuard('jwt'))
  async getRanking(
    @Request() req,
    @Query('page') page?: string,
    @Query('limit') limit?: string,
  ) {
    return this.usersService.getRanking(
      parseInt(page || '1', 10),
      parseInt(limit || '20', 10),
      req.user.id,
    );
  }

  @Get(':userId/matches/all')
  @UseGuards(AuthGuard('jwt'))
  async getUserPredictions(@Param('userId') userId: string, @Request() req) {
    return this.usersService.getUserPredictions(userId, req.user.id);
  }

  @Get('matches/:matchId')
  @UseGuards(AuthGuard('jwt'))
  async getMatchPredictions(
    @Param('matchId') matchId: string,
    @Query('page') page?: string,
    @Query('limit') limit?: string,
  ) {
    return this.usersService.getMatchPredictions(
      matchId,
      parseInt(page || '1', 10),
      parseInt(limit || '30', 10),
    );
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

    const mimeMatch = body.image.match(/^data:image\/(png|jpeg|jpg|gif|webp);base64,/);
    if (!mimeMatch) {
      throw new BadRequestException('Formato de imagen invalido. Solo se permiten: png, jpeg, jpg, gif, webp');
    }

    if (body.image.includes('image/svg')) {
      throw new BadRequestException('Formato SVG no permitido');
    }

    if (body.image.length > 1.5 * 1024 * 1024) {
      throw new BadRequestException('La imagen no puede superar 1MB');
    }

    const base64Data = body.image.split(',')[1];
    if (!base64Data) {
      throw new BadRequestException('Datos de imagen invalidos');
    }

    const fileBuffer = Buffer.from(base64Data, 'base64');

    const declaredType = mimeMatch[1];
    const expectedSignatures = IMAGE_MAGIC_BYTES[declaredType];
    if (!expectedSignatures) {
      throw new BadRequestException('Formato de imagen no soportado');
    }

    const matchesMagicBytes = expectedSignatures.some((signature) =>
      signature.every((byte, index) => fileBuffer[index] === byte),
    );
    if (!matchesMagicBytes) {
      throw new BadRequestException('El contenido del archivo no coincide con el formato declarado');
    }

    const decoded = fileBuffer.toString('utf8').toLowerCase();
    const dangerousPatterns = ['<script', 'javascript:', 'onerror', 'onload', 'eval(', '<svg', '<?xml'];
    if (dangerousPatterns.some((pattern) => decoded.includes(pattern))) {
      throw new BadRequestException('La imagen contiene contenido no permitido');
    }

    const ext = declaredType === 'jpeg' ? 'jpg' : declaredType;
    const uploadsDir = path.join(process.cwd(), 'uploads', 'avatars');
    await fs.mkdir(uploadsDir, { recursive: true });

    const filename = `${userId}.${ext}`;
    const filePath = path.join(uploadsDir, filename);

    const extensions = ['png', 'jpg', 'gif', 'webp'];
    for (const e of extensions) {
      const old = path.join(uploadsDir, `${userId}.${e}`);
      if (e !== ext) {
        await fs.access(old).then(() => fs.unlink(old)).catch(() => {});
      }
    }

    await fs.writeFile(filePath, fileBuffer);

    const imageUrl = `/uploads/avatars/${filename}`;
    return this.usersService.updateProfileImage(userId, req.user.id, imageUrl);
  }

  @Post('reset-password')
  @Throttle({ short: { limit: 3, ttl: 60000 } })
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
