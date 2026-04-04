import { Entity, PrimaryColumn, Column, OneToMany, CreateDateColumn } from 'typeorm';
import { Team } from './team.entity';
import { Match } from '../../matches/entities/match.entity';

@Entity('tournament_groups')
export class TournamentGroup {
  @PrimaryColumn({ type: 'char', length: 1 })
  id: string;

  @Column({ type: 'varchar', length: 50 })
  name: string;

  @OneToMany(() => Team, (team) => team.group)
  teams: Team[];

  @OneToMany(() => Match, (match) => match.group)
  matches: Match[];
}
