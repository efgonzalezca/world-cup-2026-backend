import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddUserNotifyTrigger1776865198208 implements MigrationInterface {
  name = 'AddUserNotifyTrigger1776865198208';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE OR REPLACE FUNCTION notify_user_changed() RETURNS trigger AS $$
      DECLARE
        payload json;
      BEGIN
        IF (TG_OP = 'DELETE') THEN
          payload := json_build_object(
            'op', TG_OP,
            'id', OLD.id,
            'is_active', OLD.is_active
          );
        ELSE
          payload := json_build_object(
            'op', TG_OP,
            'id', NEW.id,
            'is_active', NEW.is_active
          );
        END IF;
        PERFORM pg_notify('user_changed', payload::text);
        RETURN NULL;
      END;
      $$ LANGUAGE plpgsql;
    `);

    await queryRunner.query(`
      DROP TRIGGER IF EXISTS user_changed_trg ON "users";
    `);

    await queryRunner.query(`
      CREATE TRIGGER user_changed_trg
      AFTER INSERT OR UPDATE OR DELETE ON "users"
      FOR EACH ROW
      EXECUTE FUNCTION notify_user_changed();
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TRIGGER IF EXISTS user_changed_trg ON "users"`);
    await queryRunner.query(`DROP FUNCTION IF EXISTS notify_user_changed()`);
  }
}