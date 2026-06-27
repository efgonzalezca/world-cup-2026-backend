import { MigrationInterface, QueryRunner } from "typeorm";

export class AddMatchNumber1782573982064 implements MigrationInterface {
    name = 'AddMatchNumber1782573982064'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "matches" ADD "match_number" integer`);

        // Backfill: numera los partidos existentes 1..N por orden de torneo
        // (fase, luego fecha dentro de la fase). ROW_NUMBER garantiza unicidad.
        await queryRunner.query(`
            UPDATE "matches" m
            SET "match_number" = sub.rn
            FROM (
                SELECT id, ROW_NUMBER() OVER (
                    ORDER BY
                        CASE phase
                            WHEN 'group' THEN 1
                            WHEN 'round_of_32' THEN 2
                            WHEN 'round_of_16' THEN 3
                            WHEN 'quarter' THEN 4
                            WHEN 'semi' THEN 5
                            WHEN 'third_place' THEN 6
                            WHEN 'final' THEN 7
                        END,
                        match_date
                ) AS rn
                FROM "matches"
            ) sub
            WHERE m.id = sub.id
        `);

        await queryRunner.query(`CREATE UNIQUE INDEX "IDX_matches_match_number" ON "matches" ("match_number") `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "public"."IDX_matches_match_number"`);
        await queryRunner.query(`ALTER TABLE "matches" DROP COLUMN "match_number"`);
    }

}
