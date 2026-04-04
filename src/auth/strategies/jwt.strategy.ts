import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from '../../users/entities/user.entity';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: process.env.JWT_SECRET || 'wc2026_jwt_secret_key_2026',
    });
  }

  async validate(payload: { sub: string; email: string; role: string }) {
    const user = await this.userRepository.findOne({ where: { id: payload.sub } });
    if (!user || !user.is_active) {
      throw new UnauthorizedException('Usuario inactivo o no encontrado');
    }
    return { id: user.id, email: user.email, role: user.role, nickname: user.nickname };
  }
}
