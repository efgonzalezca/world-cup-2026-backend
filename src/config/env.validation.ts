import 'dotenv/config';

const REQUIRED_ENV_VARS = [
  // Database
  'DB_HOST',
  'DB_PORT',
  'DB_USERNAME',
  'DB_PASSWORD',
  'DB_DATABASE',
  'DB_POOL_MAX',
  'DB_POOL_MIN',

  // Redis
  'REDIS_HOST',
  'REDIS_PORT',
  'REDIS_DB',

  // JWT
  'JWT_SECRET',
  'JWT_EXPIRATION',

  // Security
  'SALT_ROUNDS',

  // Server
  'PORT',
  'NODE_ENV',

  // CORS
  'CORS_ORIGIN',
];

const missing = REQUIRED_ENV_VARS.filter((key) => {
  const value = process.env[key];
  return value === undefined || value === '';
});

if (missing.length > 0) {
  console.error(
    '\n========================================\n' +
      ' Missing required environment variables:\n' +
      '========================================\n' +
      missing.map((v) => `  - ${v}`).join('\n') +
      '\n\nCopy .env.template to .env and fill in all values.\n',
  );
  process.exit(1);
}
