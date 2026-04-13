import { Entity, PrimaryGeneratedColumn, Column, OneToMany, OneToOne, CreateDateColumn, UpdateDateColumn, Index } from 'typeorm';
import { UserMatch } from './user-match.entity';
import { UserPodium } from './user-podium.entity';

@Entity('users')
@Index('IDX_users_active_score', ['is_active', 'score'])
@Index('IDX_users_is_active', ['is_active'])
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 255, unique: true })
  email: string;

  @Column({ type: 'varchar', length: 20, unique: true })
  nickname: string;

  @Column({ type: 'enum', enum: ['admin', 'user'], default: 'user' })
  role: 'admin' | 'user';

  @Column({ type: 'varchar', length: 255 })
  password: string;

  @Column({ type: 'boolean', default: false })
  is_temp_password: boolean;

  @Column({ type: 'timestamp', nullable: true })
  temp_password_expires: Date | null;

  @Column({ type: 'varchar', length: 100 })
  names: string;

  @Column({ type: 'varchar', length: 100 })
  surnames: string;

  @Column({ type: 'varchar', length: 15 })
  cellphone: string;

  @Column({ type: 'int', default: 0 })
  score: number;

  @Column({ type: 'int', default: 0 })
  podium_score: number;

  @Column({ type: 'text', nullable: true })
  profile_image: string | null;

  @Column({ type: 'boolean', default: false })
  is_active: boolean;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

  @OneToMany(() => UserMatch, (um) => um.user)
  predictions: UserMatch[];

  @OneToOne(() => UserPodium, (up) => up.user)
  podium: UserPodium;
}
