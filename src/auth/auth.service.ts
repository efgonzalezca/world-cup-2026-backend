import { Injectable, UnauthorizedException, Logger } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '../users/entities/user.entity';
import { LoginDto } from './dto/login.dto';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly jwtService: JwtService,
  ) {}

  async login(loginDto: LoginDto) {
    const { email, password } = loginDto;

    const user = await this.userRepository.findOne({
      where: { email },
    });

    if (!user) {
      throw new UnauthorizedException('Credenciales invalidas');
    }

    if (!user.is_active) {
      throw new UnauthorizedException('Cuenta inactiva. Contacte al administrador para activar su cuenta.');
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      throw new UnauthorizedException('Credenciales invalidas');
    }

    const isTempPassword = user.is_temp_password;

    if (isTempPassword && user.temp_password_expires && new Date() > user.temp_password_expires) {
      throw new UnauthorizedException('La contrasena temporal ha expirado. Solicite una nueva.');
    }

    const payload = { sub: user.id, email: user.email, role: user.role };
    const token = this.jwtService.sign(payload);

    this.logger.log(`User ${user.email} logged in successfully`);

    const { password: _, ...userData } = user;

    return {
      access_token: token,
      user: userData,
      is_temp_password: isTempPassword,
    };
  }
}
