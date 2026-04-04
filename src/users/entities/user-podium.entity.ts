import { Entity, PrimaryGeneratedColumn, Column, OneToOne, ManyToOne, JoinColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { Team } from '../../teams/entities/team.entity';

@Entity('user_podiums')
export class UserPodium {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid', unique: true })
  user_id: string;

  @Column({ type: 'varchar', length: 10, nullable: true })
  champion_team_id: string;

  @Column({ type: 'varchar', length: 10, nullable: true })
  runner_up_team_id: string;

  @Column({ type: 'varchar', length: 10, nullable: true })
  third_place_team_id: string;

  @OneToOne(() => User, (u) => u.podium)
  @JoinColumn({ name: 'user_id' })
  user: User;

  @ManyToOne(() => Team, { nullable: true })
  @JoinColumn({ name: 'champion_team_id' })
  champion_team: Team;

  @ManyToOne(() => Team, { nullable: true })
  @JoinColumn({ name: 'runner_up_team_id' })
  runner_up_team: Team;

  @ManyToOne(() => Team, { nullable: true })
  @JoinColumn({ name: 'third_place_team_id' })
  third_place_team: Team;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;
}
