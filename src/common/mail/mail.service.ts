import { Injectable, InternalServerErrorException, Logger, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';
import * as path from 'path';

const LOGO_FILENAME = 'fifa-wc2026-white.png';
const LOGO_CID = 'fifa-wc2026-logo';
const LOGO_PATH = path.join(__dirname, 'assets', LOGO_FILENAME);

@Injectable()
export class MailService implements OnModuleInit, OnModuleDestroy {
  private readonly logger = new Logger(MailService.name);
  private transporter: nodemailer.Transporter | null = null;

  constructor(private readonly configService: ConfigService) { }

  async onModuleInit(): Promise<void> {
    const host = this.configService.get<string>('MAIL_HOST');
    const port = parseInt(this.configService.get<string>('MAIL_PORT') ?? '587', 10);
    const user = this.configService.get<string>('MAIL_USER');
    const pass = this.configService.get<string>('MAIL_PASS');

    if (!host || !user || !pass) {
      this.logger.warn('Mail transport not configured (MAIL_HOST/MAIL_USER/MAIL_PASS missing). Emails will not be sent.');
      return;
    }

    this.transporter = nodemailer.createTransport({
      host,
      port,
      secure: port === 465,
      auth: { user, pass },
    });

    try {
      await this.transporter.verify();
      this.logger.log(`Mail transport ready (host=${host} port=${port})`);
    } catch (err) {
      this.logger.error(`Mail transport verification failed: ${(err as Error).message}`);
    }
  }

  async onModuleDestroy(): Promise<void> {
    this.transporter?.close();
    this.transporter = null;
  }

  async sendPasswordReset(to: string, tempPassword: string, expiresInMinutes: number): Promise<void> {
    if (!this.transporter) {
      this.logger.error(`Cannot send password reset to ${to}: mail transporter not configured`);
      throw new InternalServerErrorException('Servicio de correo no disponible');
    }

    const from = this.buildFromHeader();
    const loginUrl = `${this.configService.get<string>('CORS_ORIGIN') ?? ''}/login`;
    const subject = 'Contraseña temporal - Polla Mundialista FIFA 2026';
    const html = this.renderPasswordResetTemplate(tempPassword, expiresInMinutes, loginUrl, `cid:${LOGO_CID}`);
    const text = this.renderPasswordResetText(tempPassword, expiresInMinutes, loginUrl);

    try {
      const info = await this.transporter.sendMail({
        from,
        to,
        subject,
        html,
        text,
        attachments: [{ filename: LOGO_FILENAME, path: LOGO_PATH, cid: LOGO_CID }],
      });
      this.logger.log(`Password reset email sent to ${to} (messageId=${info.messageId})`);
    } catch (err) {
      this.logger.error(`Failed to send password reset to ${to}: ${(err as Error).message}`);
      throw new InternalServerErrorException('No se pudo enviar el correo de recuperacion');
    }
  }

  private buildFromHeader(): string {
    const fromEmail = this.configService.get<string>('MAIL_FROM');
    const fromName = this.configService.get<string>('MAIL_FROM_NAME');
    if (fromEmail && fromName) return `"${fromName}" <${fromEmail}>`;
    return fromEmail ?? '';
  }

  private renderPasswordResetText(tempPassword: string, expiresInMinutes: number, loginUrl: string): string {
    return [
      'Polla Mundialista FIFA 2026',
      '',
      'Generamos una contraseña temporal para tu cuenta.',
      `Contraseña temporal: ${tempPassword}`,
      `Vence en ${expiresInMinutes} minutos.`,
      '',
      `Ingresa aqui: ${loginUrl}`,
      '',
      'Si no solicitaste el cambio, ignora este correo.',
    ].join('\n');
  }

  private renderPasswordResetTemplate(tempPassword: string, expiresInMinutes: number, loginUrl: string, logoUrl: string): string {
    return `<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contraseña temporal - Polla Mundialista FIFA 2026</title>
</head>
<body style="margin:0;padding:0;background:#F8FAFC;font-family:'Inter','Segoe UI',-apple-system,BlinkMacSystemFont,sans-serif;color:#00173A;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background:#F8FAFC;padding:40px 16px;">
    <tr>
      <td align="center">
        <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="max-width:480px;background:#FFFFFF;border-radius:16px;overflow:hidden;box-shadow:0 4px 12px rgba(0,0,0,0.06);">
          <tr>
            <td align="center" bgcolor="#00173A" style="background-color:#00173A;background-image:linear-gradient(135deg,#00173A 0%,#002855 50%,#00173A 100%);padding:36px 24px 32px;">
              <img src="${logoUrl}" alt="Copa Mundial de la FIFA 2026" width="160" height="64" style="display:block;margin:0 auto 18px;height:64px;width:auto;max-width:200px;border:0;outline:none;text-decoration:none;" />
              <div style="font-size:11px;font-weight:700;color:#2DE2B1;text-transform:uppercase;letter-spacing:0.18em;margin:0 0 10px;">
                Copa Mundial de la FIFA 2026
              </div>
              <div style="font-size:24px;font-weight:800;color:#FFFFFF;letter-spacing:-0.01em;line-height:1.2;margin:0 0 12px;">
                <font color="#FFFFFF">Polla Mundialista</font>
              </div>
              <div style="display:inline-block;width:40px;height:3px;background:#2DE2B1;border-radius:2px;"></div>
            </td>
          </tr>
          <tr>
            <td style="padding:32px 28px 8px;">
              <h1 style="margin:0 0 12px;font-size:18px;font-weight:700;color:#00173A;">
                Restablece tu contraseña
              </h1>
              <p style="margin:0 0 22px;font-size:14px;line-height:1.6;color:#475569;">
                Generamos una contraseña temporal para tu cuenta. Usala para iniciar sesión y, una vez dentro, te pediremos crear una nueva contraseña.
              </p>
              <div style="background:#F1F5F9;border:1px solid #E2E8F0;border-radius:12px;padding:20px 16px;text-align:center;margin-bottom:20px;">
                <div style="font-size:10px;font-weight:600;color:#94A3B8;text-transform:uppercase;letter-spacing:0.15em;margin-bottom:10px;">
                  Contraseña temporal
                </div>
                <div style="font-family:'Courier New',monospace;font-size:22px;font-weight:800;color:#00173A;letter-spacing:0.1em;">
                  ${tempPassword}
                </div>
              </div>
              <p style="margin:0 0 28px;font-size:12px;line-height:1.6;color:#94A3B8;text-align:center;">
                Esta contraseña vence en <strong style="color:#DC2626;">${expiresInMinutes} minutos</strong>. Si no solicitaste el cambio, ignora este correo.
              </p>
              <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                  <td align="center" style="padding-bottom:8px;">
                    <a href="${loginUrl}" target="_blank" style="display:inline-block;background:#017CFC;color:#FFFFFF;text-decoration:none;font-weight:700;font-size:14px;padding:13px 30px;border-radius:8px;">
                      Ingresar a la plataforma
                    </a>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td align="center" style="padding:24px;border-top:1px solid #F1F5F9;">
              <div style="font-size:11px;color:#94A3B8;letter-spacing:0.05em;">
                Copa Mundial de la FIFA 2026 - Canada - Mexico - USA
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</body>
</html>`;
  }
}