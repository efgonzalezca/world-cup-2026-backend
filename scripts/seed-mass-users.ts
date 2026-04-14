import { DataSource } from 'typeorm';
import { config } from 'dotenv';
import * as bcrypt from 'bcrypt';
import { Logger } from '@nestjs/common';

config();

const logger = new Logger('MassUserSeeder');

const TOTAL_USERS = 200;
const PASSWORD = 'Test1234!';
const SALT_ROUNDS = 10;

// Latin-american style nicknames for realism
const prefixes = [
  'crack', 'gol', 'fut', 'titan', 'king', 'pro', 'star', 'top', 'mega', 'super',
  'turbo', 'max', 'ultra', 'neo', 'fire', 'wolf', 'lion', 'hawk', 'bolt', 'ace',
  'flash', 'rock', 'iron', 'sky', 'blade', 'dark', 'ice', 'storm', 'rush', 'jet',
  'ninja', 'chief', 'boss', 'duke', 'lord', 'epic', 'gold', 'red', 'blue', 'wild',
];

const names = [
  'Andres', 'Santiago', 'Mateo', 'Sebastian', 'Nicolas', 'Samuel', 'Daniel', 'David',
  'Alejandro', 'Miguel', 'Juan', 'Carlos', 'Pedro', 'Luis', 'Jorge', 'Diego',
  'Camila', 'Valentina', 'Sofia', 'Isabella', 'Mariana', 'Gabriela', 'Laura', 'Ana',
  'Paula', 'Maria', 'Lucia', 'Carolina', 'Andrea', 'Natalia', 'Juliana', 'Daniela',
  'Felipe', 'Tomas', 'Emilio', 'Ricardo', 'Fernando', 'Sergio', 'Oscar', 'Mario',
];

const surnames = [
  'Garcia', 'Rodriguez', 'Martinez', 'Lopez', 'Hernandez', 'Gonzalez', 'Perez', 'Sanchez',
  'Ramirez', 'Torres', 'Flores', 'Rivera', 'Gomez', 'Diaz', 'Cruz', 'Morales',
  'Reyes', 'Gutierrez', 'Ortiz', 'Ramos', 'Vargas', 'Castro', 'Romero', 'Alvarez',
  'Jimenez', 'Ruiz', 'Mendoza', 'Herrera', 'Medina', 'Aguilar', 'Vega', 'Molina',
  'Navarro', 'Guerrero', 'Silva', 'Rojas', 'Campos', 'Castillo', 'Nunez', 'Rios',
];

function generateNickname(i: number): string {
  const prefix = prefixes[i % prefixes.length];
  const num = Math.floor(i / prefixes.length) + 1;
  return `${prefix}_${num.toString().padStart(3, '0')}`;
}

function pickRandom<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)];
}

async function bootstrap() {
  const dataSource = new DataSource({
    type: 'postgres',
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5432', 10),
    username: process.env.DB_USERNAME || 'wc2026_user',
    password: process.env.DB_PASSWORD || 'wc2026_pass',
    database: process.env.DB_DATABASE || 'world_cup_2026',
  });

  await dataSource.initialize();
  logger.log('Connected to database');

  const queryRunner = dataSource.createQueryRunner();
  await queryRunner.connect();
  await queryRunner.startTransaction();

  try {
    // 1. Hash password once (shared by all test users)
    logger.log('Hashing password...');
    const hashedPassword = await bcrypt.hash(PASSWORD, SALT_ROUNDS);

    // 2. Check how many test users already exist
    const existing = await queryRunner.query(
      `SELECT COUNT(*) as cnt FROM users WHERE email LIKE 'testuser_%@wc2026.test'`,
    );
    const existingCount = parseInt(existing[0].cnt, 10);
    if (existingCount >= TOTAL_USERS) {
      logger.log(`Already have ${existingCount} test users, skipping creation.`);
      await queryRunner.rollbackTransaction();
      await queryRunner.release();
      await dataSource.destroy();
      process.exit(0);
    }

    // 3. Delete existing test users to start fresh
    if (existingCount > 0) {
      logger.log(`Removing ${existingCount} existing test users...`);
      await queryRunner.query(
        `DELETE FROM user_podiums WHERE user_id IN (SELECT id FROM users WHERE email LIKE 'testuser_%@wc2026.test')`,
      );
      await queryRunner.query(
        `DELETE FROM user_matches WHERE user_id IN (SELECT id FROM users WHERE email LIKE 'testuser_%@wc2026.test')`,
      );
      await queryRunner.query(
        `DELETE FROM users WHERE email LIKE 'testuser_%@wc2026.test'`,
      );
    }

    // 4. Get all match IDs
    const matchRows: { id: string }[] = await queryRunner.query(`SELECT id FROM matches ORDER BY match_date`);
    const matchIds = matchRows.map((r) => r.id);
    logger.log(`Found ${matchIds.length} matches`);

    // 5. Insert users in batches of 50
    logger.log(`Creating ${TOTAL_USERS} users...`);
    const BATCH = 50;
    const userIds: string[] = [];

    for (let batch = 0; batch < TOTAL_USERS; batch += BATCH) {
      const batchSize = Math.min(BATCH, TOTAL_USERS - batch);
      const values: string[] = [];
      const params: unknown[] = [];

      for (let i = 0; i < batchSize; i++) {
        const idx = batch + i;
        const nickname = generateNickname(idx);
        const email = `testuser_${idx.toString().padStart(3, '0')}@wc2026.test`;
        const name = pickRandom(names);
        const surname = pickRandom(surnames);
        const phone = `3${Math.floor(100000000 + Math.random() * 900000000)}`;
        const offset = i * 7;
        values.push(
          `($${offset + 1}, $${offset + 2}, $${offset + 3}, $${offset + 4}, $${offset + 5}, $${offset + 6}, $${offset + 7}, 'user', true, false)`,
        );
        params.push(email, nickname, hashedPassword, name, surname, phone, 0);
      }

      const inserted: { id: string }[] = await queryRunner.query(
        `INSERT INTO users (email, nickname, password, names, surnames, cellphone, score, role, is_active, is_temp_password)
         VALUES ${values.join(', ')}
         RETURNING id`,
        params,
      );
      userIds.push(...inserted.map((r) => r.id));
      logger.log(`  Users ${batch + 1}-${batch + batchSize} created`);
    }

    // 6. Create user_matches for all users x all matches
    logger.log(`Creating user_matches (${userIds.length} users x ${matchIds.length} matches = ${userIds.length * matchIds.length} rows)...`);
    const UM_BATCH = 500; // rows per insert
    let umCount = 0;

    for (let u = 0; u < userIds.length; u++) {
      const userId = userIds[u];
      for (let m = 0; m < matchIds.length; m += UM_BATCH) {
        const slice = matchIds.slice(m, m + UM_BATCH);
        const values: string[] = [];
        const params: unknown[] = [];

        slice.forEach((matchId, i) => {
          const offset = i * 2;
          values.push(`($${offset + 1}, $${offset + 2})`);
          params.push(userId, matchId);
        });

        await queryRunner.query(
          `INSERT INTO user_matches (user_id, match_id) VALUES ${values.join(', ')}`,
          params,
        );
        umCount += slice.length;
      }
      if ((u + 1) % 50 === 0) {
        logger.log(`  user_matches: ${u + 1}/${userIds.length} users done (${umCount} rows)`);
      }
    }
    logger.log(`  Total user_matches created: ${umCount}`);

    // 7. Create user_podiums
    logger.log('Creating user_podiums...');
    for (let batch = 0; batch < userIds.length; batch += BATCH) {
      const slice = userIds.slice(batch, batch + BATCH);
      const values: string[] = [];
      const params: unknown[] = [];

      slice.forEach((userId, i) => {
        values.push(`($${i + 1})`);
        params.push(userId);
      });

      await queryRunner.query(
        `INSERT INTO user_podiums (user_id) VALUES ${values.join(', ')}`,
        params,
      );
    }

    // 8. Generate random predictions for played matches
    // Each user gets a "style" that determines score ranges
    logger.log('Generating random predictions for played matches...');
    await queryRunner.query(`
      UPDATE user_matches um SET
        local_score = sub.ls,
        visitor_score = sub.vs
      FROM (
        SELECT
          um2.id as um_id,
          -- Random score 0-4 with bias toward lower scores
          floor(power(random(), 1.5) * 5)::int as ls,
          floor(power(random(), 1.5) * 5)::int as vs
        FROM user_matches um2
        JOIN matches m ON m.id = um2.match_id
        JOIN users u ON u.id = um2.user_id
        WHERE m.has_played = true
          AND u.email LIKE 'testuser_%@wc2026.test'
      ) sub
      WHERE um.id = sub.um_id
    `);

    // 9. Calculate points for all predictions (same formula as existing seed)
    logger.log('Calculating points...');
    await queryRunner.query(`
      UPDATE user_matches um SET
        points = sub.total,
        discriminated_points = jsonb_build_object(
          'resultPoints', sub.result_pts,
          'localScorePoints', sub.local_pts,
          'visitorScorePoints', sub.visitor_pts,
          'exactScoreBonus', sub.exact_pts,
          'drawBonus', sub.draw_pts
        )
      FROM (
        SELECT
          um2.id as um_id,
          CASE WHEN sign(um2.local_score - um2.visitor_score) = sign(m.local_result - m.visiting_result) THEN 2 ELSE 0 END as result_pts,
          CASE WHEN um2.local_score = m.local_result THEN 1 ELSE 0 END as local_pts,
          CASE WHEN um2.visitor_score = m.visiting_result THEN 1 ELSE 0 END as visitor_pts,
          CASE WHEN um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result THEN 3 ELSE 0 END as exact_pts,
          CASE WHEN um2.local_score = um2.visitor_score AND m.local_result = m.visiting_result
                    AND NOT (um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result) THEN 1 ELSE 0 END as draw_pts,
          CASE WHEN sign(um2.local_score - um2.visitor_score) = sign(m.local_result - m.visiting_result) THEN 2 ELSE 0 END
          + CASE WHEN um2.local_score = m.local_result THEN 1 ELSE 0 END
          + CASE WHEN um2.visitor_score = m.visiting_result THEN 1 ELSE 0 END
          + CASE WHEN um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result THEN 3 ELSE 0 END
          + CASE WHEN um2.local_score = um2.visitor_score AND m.local_result = m.visiting_result
                      AND NOT (um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result) THEN 1 ELSE 0 END
          as total
        FROM user_matches um2
        JOIN matches m ON m.id = um2.match_id
        JOIN users u ON u.id = um2.user_id
        WHERE m.has_played = true
          AND um2.local_score IS NOT NULL AND um2.visitor_score IS NOT NULL
          AND u.email LIKE 'testuser_%@wc2026.test'
      ) sub
      WHERE um.id = sub.um_id
    `);

    // 10. Update user total scores
    logger.log('Updating user total scores...');
    await queryRunner.query(`
      UPDATE users u SET score = coalesce(sub.total_points, 0)
      FROM (
        SELECT um.user_id, SUM(um.points) as total_points
        FROM user_matches um
        JOIN matches m ON m.id = um.match_id
        WHERE m.has_played = true
          AND um.user_id = ANY($1::uuid[])
        GROUP BY um.user_id
      ) sub
      WHERE u.id = sub.user_id
    `, [userIds]);

    await queryRunner.commitTransaction();

    // Final stats
    const stats = await dataSource.query(`
      SELECT
        (SELECT COUNT(*) FROM users WHERE is_active = true) as total_users,
        (SELECT COUNT(*) FROM users WHERE email LIKE 'testuser_%@wc2026.test') as test_users,
        (SELECT MIN(score) FROM users WHERE email LIKE 'testuser_%@wc2026.test') as min_score,
        (SELECT MAX(score) FROM users WHERE email LIKE 'testuser_%@wc2026.test') as max_score,
        (SELECT ROUND(AVG(score)) FROM users WHERE email LIKE 'testuser_%@wc2026.test') as avg_score
    `);

    logger.log('=== SEED COMPLETE ===');
    logger.log(`Total active users: ${stats[0].total_users}`);
    logger.log(`Test users created: ${stats[0].test_users}`);
    logger.log(`Score range: ${stats[0].min_score} - ${stats[0].max_score} (avg: ${stats[0].avg_score})`);
    logger.log(`All test users have password: ${PASSWORD}`);

    await queryRunner.release();
    await dataSource.destroy();
    process.exit(0);
  } catch (error) {
    await queryRunner.rollbackTransaction();
    await queryRunner.release();
    await dataSource.destroy();
    throw error;
  }
}

bootstrap().catch((err) => {
  console.error('Mass user seed failed:', err);
  process.exit(1);
});
