import { Injectable, NestMiddleware } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class JwtUploadsMiddleware implements NestMiddleware {
  constructor(private readonly jwtService: JwtService) {}

  use(req: Request, res: Response, next: NextFunction) {
    const authHeader = req.headers.authorization;
    const token = authHeader?.startsWith('Bearer ')
      ? authHeader.split(' ')[1]
      : (req.query.token as string | undefined);

    if (!token) {
      res.status(401).json({ message: 'Token requerido' });
      return;
    }

    try {
      this.jwtService.verify(token);
      next();
    } catch {
      res.status(401).json({ message: 'Token invalido' });
    }
  }
}
