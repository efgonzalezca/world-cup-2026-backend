import { Entity, PrimaryColumn, Column, ManyToOne, JoinColumn, CreateDateColumn } from 'typeorm';
import { TournamentGroup } from './tournament-group.entity';

@Entity('teams')
export class Team {
  @PrimaryColumn({ type: 'varchar', length: 10 })
  id: string;

  @Column({ type: 'varchar', length: 100 })
  name: string;

  @Column({ type: 'varchar', length: 500, nullable: true })
  image: string;

  @Column({ type: 'int', nullable: true })
  fifa_rank: number;

  @Column({ type: 'char', length: 1 })
  group_code: string;

  @ManyToOne(() => TournamentGroup, (group) => group.teams)
  @JoinColumn({ name: 'group_code' })
  group: TournamentGroup;

  @CreateDateColumn()
  created_at: Date;
}
