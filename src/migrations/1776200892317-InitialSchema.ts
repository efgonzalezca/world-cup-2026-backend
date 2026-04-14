import { MigrationInterface, QueryRunner } from 'typeorm';

export class InitialSchema1776200892317 implements MigrationInterface {
  name = 'InitialSchema1776200892317';

  public async up(queryRunner: QueryRunner): Promise<void> {
    // Enums
    await queryRunner.query(`
      DO $$ BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'matches_phase_enum') THEN
          CREATE TYPE "matches_phase_enum" AS ENUM('group', 'round_of_32', 'round_of_16', 'quarter', 'semi', 'third_place', 'final');
        END IF;
      END $$;
    `);
    await queryRunner.query(`
      DO $$ BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'users_role_enum') THEN
          CREATE TYPE "users_role_enum" AS ENUM('admin', 'user');
        END IF;
      END $$;
    `);

    // Extension for uuid
    await queryRunner.query(`CREATE EXTENSION IF NOT EXISTS "uuid-ossp"`);

    // tournament_groups
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "tournament_groups" (
        "id" character(1) NOT NULL,
        "name" character varying(50) NOT NULL,
        CONSTRAINT "PK_c2f8cd1faeb19919d97022068df" PRIMARY KEY ("id")
      )
    `);

    // teams
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "teams" (
        "id" character varying(10) NOT NULL,
        "name" character varying(100) NOT NULL,
        "image" character varying(500),
        "fifa_rank" integer,
        "group_code" character(1) NOT NULL,
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_7e5523774a38b08a6236d322403" PRIMARY KEY ("id"),
        CONSTRAINT "FK_217794b841871225fafcfbe08e6" FOREIGN KEY ("group_code") REFERENCES "tournament_groups"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    `);

    // users
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "users" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "email" character varying(255) NOT NULL,
        "nickname" character varying(20) NOT NULL,
        "role" "users_role_enum" NOT NULL DEFAULT 'user',
        "password" character varying(255) NOT NULL,
        "is_temp_password" boolean NOT NULL DEFAULT false,
        "temp_password_expires" TIMESTAMP,
        "names" character varying(100) NOT NULL,
        "surnames" character varying(100) NOT NULL,
        "cellphone" character varying(15) NOT NULL,
        "score" integer NOT NULL DEFAULT 0,
        "podium_score" integer NOT NULL DEFAULT 0,
        "profile_image" text,
        "is_active" boolean NOT NULL DEFAULT false,
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY ("id"),
        CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE ("email"),
        CONSTRAINT "UQ_ad02a1be8707004cb805a4b5023" UNIQUE ("nickname")
      )
    `);

    // matches
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "matches" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "phase" "matches_phase_enum" NOT NULL,
        "group_code" character(1),
        "match_date" TIMESTAMP NOT NULL,
        "local_team_id" character varying(10),
        "visiting_team_id" character varying(10),
        "local_result" integer,
        "visiting_result" integer,
        "has_played" boolean NOT NULL DEFAULT false,
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_8a22c7b2e0828988d51256117f4" PRIMARY KEY ("id"),
        CONSTRAINT "FK_bf613b7dda3744281dfdd2594d6" FOREIGN KEY ("local_team_id") REFERENCES "teams"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "FK_da5a792b155416998488c6e1b7c" FOREIGN KEY ("visiting_team_id") REFERENCES "teams"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "FK_6407acbfb91d2625e5a1e644166" FOREIGN KEY ("group_code") REFERENCES "tournament_groups"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    `);

    // user_matches
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "user_matches" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "user_id" uuid NOT NULL,
        "match_id" uuid NOT NULL,
        "local_score" integer,
        "visitor_score" integer,
        "points" integer NOT NULL DEFAULT 0,
        "discriminated_points" jsonb,
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_d5c769557c83a23403a0346234d" PRIMARY KEY ("id"),
        CONSTRAINT "UQ_0eb0da4508f93c1172e9804aa8d" UNIQUE ("user_id", "match_id"),
        CONSTRAINT "FK_b570952e4ce00c540622cb58f17" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "FK_14a8dc8f626eeb5a89329233733" FOREIGN KEY ("match_id") REFERENCES "matches"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    `);

    // user_podiums
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "user_podiums" (
        "id" uuid NOT NULL DEFAULT uuid_generate_v4(),
        "user_id" uuid NOT NULL,
        "champion_team_id" character varying(10),
        "runner_up_team_id" character varying(10),
        "third_place_team_id" character varying(10),
        "created_at" TIMESTAMP NOT NULL DEFAULT now(),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_ea2f05f5d45a72c04cf15f8ebaf" PRIMARY KEY ("id"),
        CONSTRAINT "UQ_c61493f3d05b03ed57f767bbf45" UNIQUE ("user_id"),
        CONSTRAINT "FK_c61493f3d05b03ed57f767bbf45" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "FK_ad7748056372c3283de7343fcd3" FOREIGN KEY ("champion_team_id") REFERENCES "teams"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "FK_ff19b0932f30ca352d87d283e09" FOREIGN KEY ("runner_up_team_id") REFERENCES "teams"("id") ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT "FK_365e5cdeb1b117fc3b0181f6391" FOREIGN KEY ("third_place_team_id") REFERENCES "teams"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
      )
    `);

    // app_config
    await queryRunner.query(`
      CREATE TABLE IF NOT EXISTS "app_config" (
        "key" character varying(100) NOT NULL,
        "value" text NOT NULL,
        "description" character varying(255),
        "updated_at" TIMESTAMP NOT NULL DEFAULT now(),
        CONSTRAINT "PK_e53f3c7882ebd6e79931e0fa959" PRIMARY KEY ("key")
      )
    `);

    // Indexes
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_matches_phase" ON "matches" ("phase")`);
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_matches_phase_has_played" ON "matches" ("phase", "has_played")`);
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_matches_match_date" ON "matches" ("match_date")`);
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_user_matches_user_id" ON "user_matches" ("user_id")`);
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_user_matches_match_id" ON "user_matches" ("match_id")`);
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_users_is_active" ON "users" ("is_active")`);
    await queryRunner.query(`CREATE INDEX IF NOT EXISTS "IDX_users_active_score" ON "users" ("is_active", "score")`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE IF EXISTS "app_config"`);
    await queryRunner.query(`DROP TABLE IF EXISTS "user_podiums"`);
    await queryRunner.query(`DROP TABLE IF EXISTS "user_matches"`);
    await queryRunner.query(`DROP TABLE IF EXISTS "matches"`);
    await queryRunner.query(`DROP TABLE IF EXISTS "users"`);
    await queryRunner.query(`DROP TABLE IF EXISTS "teams"`);
    await queryRunner.query(`DROP TABLE IF EXISTS "tournament_groups"`);
    await queryRunner.query(`DROP TYPE IF EXISTS "matches_phase_enum"`);
    await queryRunner.query(`DROP TYPE IF EXISTS "users_role_enum"`);
  }
}
