import { ExceptionFilter, Catch, ArgumentsHost, HttpException, Logger } from '@nestjs/common';
import { Request, Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(HttpExceptionFilter.name);

  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();
    const exceptionResponse = exception.getResponse();

    const error = typeof exceptionResponse === 'string'
      ? { message: exceptionResponse }
      : (exceptionResponse as Record<string, unknown>);

    const logPayload = {
      statusCode: status,
      method: request.method,
      path: request.url,
      message: error.message,
      ip: request.ip,
      userAgent: request.get('user-agent'),
    };

    if (status >= 500) {
      this.logger.error(JSON.stringify(logPayload));
    } else if (status >= 400) {
      this.logger.warn(JSON.stringify(logPayload));
    }

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      ...error,
    });
  }
}
