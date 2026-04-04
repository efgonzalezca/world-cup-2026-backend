import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, JoinColumn, Unique, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { Match } from '../../matches/entities/match.entity';

@Entity('user_matches')
@Unique(['user_id', 'match_id'])
export class UserMatch {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'uuid' })
  user_id: string;

  @Column({ type: 'uuid' })
  match_id: string;

  @Column({ type: 'int', nullable: true })
  local_score: number;

  @Column({ type: 'int', nullable: true })
  visitor_score: number;

  @Column({ type: 'int', default: 0 })
  points: number;

  @Column({ type: 'jsonb', nullable: true })
  discriminated_points: {
    resultPoints: number;
    localScorePoints: number;
    visitorScorePoints: number;
    exactScoreBonus: number;
    drawBonus: number;
  };

  @ManyToOne(() => User, (u) => u.predictions)
  @JoinColumn({ name: 'user_id' })
  user: User;

  @ManyToOne(() => Match, (m) => m.predictions)
  @JoinColumn({ name: 'match_id' })
  match: Match;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;
}
