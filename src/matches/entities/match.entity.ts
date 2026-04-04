import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { Team } from '../../teams/entities/team.entity';
import { TournamentGroup } from '../../teams/entities/tournament-group.entity';
import { UserMatch } from '../../users/entities/user-match.entity';

export type MatchPhase = 'group' | 'round_of_32' | 'round_of_16' | 'quarter' | 'semi' | 'third_place' | 'final';

@Entity('matches')
export class Match {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'enum', enum: ['group', 'round_of_32', 'round_of_16', 'quarter', 'semi', 'third_place', 'final'] })
  phase: MatchPhase;

  @Column({ type: 'char', length: 1, nullable: true })
  group_code: string | null;

  @Column({ type: 'timestamp' })
  match_date: Date;

  @Column({ type: 'varchar', length: 10, nullable: true })
  local_team_id: string | null;

  @Column({ type: 'varchar', length: 10, nullable: true })
  visiting_team_id: string | null;

  @Column({ type: 'int', nullable: true })
  local_result: number;

  @Column({ type: 'int', nullable: true })
  visiting_result: number;

  @Column({ type: 'boolean', default: false })
  has_played: boolean;

  @ManyToOne(() => Team, { nullable: true })
  @JoinColumn({ name: 'local_team_id' })
  local_team: Team;

  @ManyToOne(() => Team, { nullable: true })
  @JoinColumn({ name: 'visiting_team_id' })
  visiting_team: Team;

  @ManyToOne(() => TournamentGroup, (g) => g.matches, { nullable: true })
  @JoinColumn({ name: 'group_code' })
  group: TournamentGroup;

  @OneToMany(() => UserMatch, (um) => um.match)
  predictions: UserMatch[];

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;
}
