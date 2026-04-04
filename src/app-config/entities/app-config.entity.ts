import { Entity, PrimaryColumn, Column, UpdateDateColumn } from 'typeorm';

@Entity('app_config')
export class AppConfig {
  @PrimaryColumn({ type: 'varchar', length: 100 })
  key: string;

  @Column({ type: 'text' })
  value: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  description: string | null;

  @UpdateDateColumn()
  updated_at: Date;
}
