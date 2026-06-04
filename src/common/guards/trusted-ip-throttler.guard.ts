import { Injectable } from '@nestjs/common';
import { ThrottlerGuard } from '@nestjs/throttler';

/**
 * ThrottlerGuard that identifies the client by their real IP for rate limiting.
 *
 * Behind a reverse proxy (Cloudflare, ingress-nginx) req.ip is not always the
 * user's IP: ingress-nginx rewrites X-Forwarded-For with the immediate proxy's
 * address. Some providers send the real client IP in a dedicated header
 * (Cloudflare -> CF-Connecting-IP).
 *
 * The trusted header is set via env (TRUSTED_CLIENT_IP_HEADER) so the code is
 * not coupled to a provider: switching CDN means changing one variable, not the
 * code. If the env is not defined, it falls back to req.ip (resolved by
 * Express's 'trust proxy'), which is the safe default.
 *
 * SECURITY: a header is spoofable. Only set TRUSTED_CLIENT_IP_HEADER when the
 * origin is locked down to the provider's IPs; otherwise an attacker could
 * rotate the IP on every request and bypass the limit.
 */
@Injectable()
export class TrustedIpThrottlerGuard extends ThrottlerGuard {
  private readonly trustedHeader = (
    process.env.TRUSTED_CLIENT_IP_HEADER || ''
  ).toLowerCase();

  protected async getTracker(req: Record<string, any>): Promise<string> {
    if (this.trustedHeader && req.headers[this.trustedHeader]) {
      return req.headers[this.trustedHeader] as string;
    }
    return req.ip;
  }
}