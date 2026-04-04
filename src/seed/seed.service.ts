import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { TournamentGroup } from '../teams/entities/tournament-group.entity';
import { Team } from '../teams/entities/team.entity';
import { Match } from '../matches/entities/match.entity';
import { AppConfig } from '../app-config/entities/app-config.entity';

@Injectable()
export class SeedService implements OnModuleInit {
  private readonly logger = new Logger(SeedService.name);

  constructor(
    @InjectRepository(TournamentGroup)
    private readonly groupRepository: Repository<TournamentGroup>,
    @InjectRepository(Team)
    private readonly teamRepository: Repository<Team>,
    @InjectRepository(Match)
    private readonly matchRepository: Repository<Match>,
    @InjectRepository(AppConfig)
    private readonly configRepository: Repository<AppConfig>,
  ) {}

  async onModuleInit() {
    const groupCount = await this.groupRepository.count();
    if (groupCount > 0) {
      this.logger.log('Seed data already exists, skipping...');
      return;
    }
    await this.seed();
  }

  async seed() {
    this.logger.log('Seeding database...');

    // ── Groups ────────────────────────────────────────────────────────────────
    const groups = [
      { id: 'A', name: 'Grupo A' },
      { id: 'B', name: 'Grupo B' },
      { id: 'C', name: 'Grupo C' },
      { id: 'D', name: 'Grupo D' },
      { id: 'E', name: 'Grupo E' },
      { id: 'F', name: 'Grupo F' },
      { id: 'G', name: 'Grupo G' },
      { id: 'H', name: 'Grupo H' },
      { id: 'I', name: 'Grupo I' },
      { id: 'J', name: 'Grupo J' },
      { id: 'K', name: 'Grupo K' },
      { id: 'L', name: 'Grupo L' },
    ];
    await this.groupRepository.save(groups);

    // ── Teams (48) — Official FIFA World Cup 2026 Draw ────────────────────────
    const teams = [
      // Group A
      { id: 'MEX', name: 'Mexico',              group_code: 'A', fifa_rank: 15 },
      { id: 'RSA', name: 'Sudafrica',           group_code: 'A', fifa_rank: 59 },
      { id: 'KOR', name: 'Corea del Sur',       group_code: 'A', fifa_rank: 22 },
      { id: 'CZE', name: 'Chequia',             group_code: 'A', fifa_rank: 36 },
      // Group B
      { id: 'CAN', name: 'Canada',              group_code: 'B', fifa_rank: 40 },
      { id: 'BIH', name: 'Bosnia y Herzegovina', group_code: 'B', fifa_rank: 62 },
      { id: 'QAT', name: 'Qatar',               group_code: 'B', fifa_rank: 45 },
      { id: 'SUI', name: 'Suiza',               group_code: 'B', fifa_rank: 19 },
      // Group C
      { id: 'BRA', name: 'Brasil',              group_code: 'C', fifa_rank: 5 },
      { id: 'MAR', name: 'Marruecos',           group_code: 'C', fifa_rank: 14 },
      { id: 'HAI', name: 'Haiti',               group_code: 'C', fifa_rank: 90 },
      { id: 'SCO', name: 'Escocia',             group_code: 'C', fifa_rank: 39 },
      // Group D
      { id: 'USA', name: 'Estados Unidos',      group_code: 'D', fifa_rank: 11 },
      { id: 'PAR', name: 'Paraguay',            group_code: 'D', fifa_rank: 59 },
      { id: 'AUS', name: 'Australia',           group_code: 'D', fifa_rank: 24 },
      { id: 'TUR', name: 'Turquia',             group_code: 'D', fifa_rank: 23 },
      // Group E
      { id: 'GER', name: 'Alemania',            group_code: 'E', fifa_rank: 8 },
      { id: 'CUW', name: 'Curazao',             group_code: 'E', fifa_rank: 130 },
      { id: 'CIV', name: 'Costa de Marfil',     group_code: 'E', fifa_rank: 37 },
      { id: 'ECU', name: 'Ecuador',             group_code: 'E', fifa_rank: 32 },
      // Group F
      { id: 'NED', name: 'Paises Bajos',        group_code: 'F', fifa_rank: 7 },
      { id: 'JPN', name: 'Japon',               group_code: 'F', fifa_rank: 16 },
      { id: 'SWE', name: 'Suecia',              group_code: 'F', fifa_rank: 33 },
      { id: 'TUN', name: 'Tunez',               group_code: 'F', fifa_rank: 41 },
      // Group G
      { id: 'BEL', name: 'Belgica',             group_code: 'G', fifa_rank: 25 },
      { id: 'EGY', name: 'Egipto',              group_code: 'G', fifa_rank: 34 },
      { id: 'IRN', name: 'Iran',                group_code: 'G', fifa_rank: 20 },
      { id: 'NZL', name: 'Nueva Zelanda',       group_code: 'G', fifa_rank: 93 },
      // Group H
      { id: 'ESP', name: 'Espana',              group_code: 'H', fifa_rank: 2 },
      { id: 'CPV', name: 'Cabo Verde',          group_code: 'H', fifa_rank: 68 },
      { id: 'SAU', name: 'Arabia Saudita',      group_code: 'H', fifa_rank: 56 },
      { id: 'URU', name: 'Uruguay',             group_code: 'H', fifa_rank: 9 },
      // Group I
      { id: 'FRA', name: 'Francia',             group_code: 'I', fifa_rank: 3 },
      { id: 'SEN', name: 'Senegal',             group_code: 'I', fifa_rank: 17 },
      { id: 'IRQ', name: 'Irak',                group_code: 'I', fifa_rank: 63 },
      { id: 'NOR', name: 'Noruega',             group_code: 'I', fifa_rank: 47 },
      // Group J
      { id: 'ARG', name: 'Argentina',           group_code: 'J', fifa_rank: 1 },
      { id: 'ALG', name: 'Argelia',             group_code: 'J', fifa_rank: 36 },
      { id: 'AUT', name: 'Austria',             group_code: 'J', fifa_rank: 27 },
      { id: 'JOR', name: 'Jordania',            group_code: 'J', fifa_rank: 70 },
      // Group K
      { id: 'POR', name: 'Portugal',            group_code: 'K', fifa_rank: 6 },
      { id: 'COD', name: 'RD Congo',            group_code: 'K', fifa_rank: 55 },
      { id: 'UZB', name: 'Uzbekistan',          group_code: 'K', fifa_rank: 64 },
      { id: 'COL', name: 'Colombia',            group_code: 'K', fifa_rank: 10 },
      // Group L
      { id: 'ENG', name: 'Inglaterra',          group_code: 'L', fifa_rank: 13 },
      { id: 'CRO', name: 'Croacia',             group_code: 'L', fifa_rank: 12 },
      { id: 'GHA', name: 'Ghana',               group_code: 'L', fifa_rank: 48 },
      { id: 'PAN', name: 'Panama',              group_code: 'L', fifa_rank: 44 },
    ];
    await this.teamRepository.save(teams);

    // ── Matches ───────────────────────────────────────────────────────────────
    // All dates in UTC. Source: FIFA official schedule via NBC Sports.
    // ET → UTC conversion: ET + 4 hours (EDT during June/July).
    const matches: Partial<Match>[] = [

      // ────────────── GROUP A ──────────────
      { phase: 'group', group_code: 'A', match_date: new Date('2026-06-11T19:00:00Z'), local_team_id: 'MEX', visiting_team_id: 'RSA' },
      { phase: 'group', group_code: 'A', match_date: new Date('2026-06-12T02:00:00Z'), local_team_id: 'KOR', visiting_team_id: 'CZE' },
      { phase: 'group', group_code: 'A', match_date: new Date('2026-06-18T16:00:00Z'), local_team_id: 'CZE', visiting_team_id: 'RSA' },
      { phase: 'group', group_code: 'A', match_date: new Date('2026-06-19T01:00:00Z'), local_team_id: 'MEX', visiting_team_id: 'KOR' },
      { phase: 'group', group_code: 'A', match_date: new Date('2026-06-25T01:00:00Z'), local_team_id: 'CZE', visiting_team_id: 'MEX' },
      { phase: 'group', group_code: 'A', match_date: new Date('2026-06-25T01:00:00Z'), local_team_id: 'RSA', visiting_team_id: 'KOR' },

      // ────────────── GROUP B ──────────────
      { phase: 'group', group_code: 'B', match_date: new Date('2026-06-12T19:00:00Z'), local_team_id: 'CAN', visiting_team_id: 'BIH' },
      { phase: 'group', group_code: 'B', match_date: new Date('2026-06-13T19:00:00Z'), local_team_id: 'QAT', visiting_team_id: 'SUI' },
      { phase: 'group', group_code: 'B', match_date: new Date('2026-06-18T19:00:00Z'), local_team_id: 'SUI', visiting_team_id: 'BIH' },
      { phase: 'group', group_code: 'B', match_date: new Date('2026-06-18T22:00:00Z'), local_team_id: 'CAN', visiting_team_id: 'QAT' },
      { phase: 'group', group_code: 'B', match_date: new Date('2026-06-24T19:00:00Z'), local_team_id: 'SUI', visiting_team_id: 'CAN' },
      { phase: 'group', group_code: 'B', match_date: new Date('2026-06-24T19:00:00Z'), local_team_id: 'BIH', visiting_team_id: 'QAT' },

      // ────────────── GROUP C ──────────────
      { phase: 'group', group_code: 'C', match_date: new Date('2026-06-13T22:00:00Z'), local_team_id: 'BRA', visiting_team_id: 'MAR' },
      { phase: 'group', group_code: 'C', match_date: new Date('2026-06-14T01:00:00Z'), local_team_id: 'HAI', visiting_team_id: 'SCO' },
      { phase: 'group', group_code: 'C', match_date: new Date('2026-06-19T22:00:00Z'), local_team_id: 'SCO', visiting_team_id: 'MAR' },
      { phase: 'group', group_code: 'C', match_date: new Date('2026-06-20T01:00:00Z'), local_team_id: 'BRA', visiting_team_id: 'HAI' },
      { phase: 'group', group_code: 'C', match_date: new Date('2026-06-24T22:00:00Z'), local_team_id: 'SCO', visiting_team_id: 'BRA' },
      { phase: 'group', group_code: 'C', match_date: new Date('2026-06-24T22:00:00Z'), local_team_id: 'MAR', visiting_team_id: 'HAI' },

      // ────────────── GROUP D ──────────────
      { phase: 'group', group_code: 'D', match_date: new Date('2026-06-13T01:00:00Z'), local_team_id: 'USA', visiting_team_id: 'PAR' },
      { phase: 'group', group_code: 'D', match_date: new Date('2026-06-14T04:00:00Z'), local_team_id: 'AUS', visiting_team_id: 'TUR' },
      { phase: 'group', group_code: 'D', match_date: new Date('2026-06-19T19:00:00Z'), local_team_id: 'USA', visiting_team_id: 'AUS' },
      { phase: 'group', group_code: 'D', match_date: new Date('2026-06-20T04:00:00Z'), local_team_id: 'TUR', visiting_team_id: 'PAR' },
      { phase: 'group', group_code: 'D', match_date: new Date('2026-06-26T02:00:00Z'), local_team_id: 'TUR', visiting_team_id: 'USA' },
      { phase: 'group', group_code: 'D', match_date: new Date('2026-06-26T02:00:00Z'), local_team_id: 'PAR', visiting_team_id: 'AUS' },

      // ────────────── GROUP E ──────────────
      { phase: 'group', group_code: 'E', match_date: new Date('2026-06-14T17:00:00Z'), local_team_id: 'GER', visiting_team_id: 'CUW' },
      { phase: 'group', group_code: 'E', match_date: new Date('2026-06-14T23:00:00Z'), local_team_id: 'CIV', visiting_team_id: 'ECU' },
      { phase: 'group', group_code: 'E', match_date: new Date('2026-06-20T20:00:00Z'), local_team_id: 'GER', visiting_team_id: 'CIV' },
      { phase: 'group', group_code: 'E', match_date: new Date('2026-06-21T00:00:00Z'), local_team_id: 'ECU', visiting_team_id: 'CUW' },
      { phase: 'group', group_code: 'E', match_date: new Date('2026-06-25T20:00:00Z'), local_team_id: 'ECU', visiting_team_id: 'GER' },
      { phase: 'group', group_code: 'E', match_date: new Date('2026-06-25T20:00:00Z'), local_team_id: 'CUW', visiting_team_id: 'CIV' },

      // ────────────── GROUP F ──────────────
      { phase: 'group', group_code: 'F', match_date: new Date('2026-06-14T20:00:00Z'), local_team_id: 'NED', visiting_team_id: 'JPN' },
      { phase: 'group', group_code: 'F', match_date: new Date('2026-06-15T02:00:00Z'), local_team_id: 'SWE', visiting_team_id: 'TUN' },
      { phase: 'group', group_code: 'F', match_date: new Date('2026-06-20T17:00:00Z'), local_team_id: 'NED', visiting_team_id: 'SWE' },
      { phase: 'group', group_code: 'F', match_date: new Date('2026-06-21T04:00:00Z'), local_team_id: 'TUN', visiting_team_id: 'JPN' },
      { phase: 'group', group_code: 'F', match_date: new Date('2026-06-25T23:00:00Z'), local_team_id: 'JPN', visiting_team_id: 'SWE' },
      { phase: 'group', group_code: 'F', match_date: new Date('2026-06-25T23:00:00Z'), local_team_id: 'TUN', visiting_team_id: 'NED' },

      // ────────────── GROUP G ──────────────
      { phase: 'group', group_code: 'G', match_date: new Date('2026-06-15T19:00:00Z'), local_team_id: 'BEL', visiting_team_id: 'EGY' },
      { phase: 'group', group_code: 'G', match_date: new Date('2026-06-16T01:00:00Z'), local_team_id: 'IRN', visiting_team_id: 'NZL' },
      { phase: 'group', group_code: 'G', match_date: new Date('2026-06-21T19:00:00Z'), local_team_id: 'BEL', visiting_team_id: 'IRN' },
      { phase: 'group', group_code: 'G', match_date: new Date('2026-06-22T01:00:00Z'), local_team_id: 'NZL', visiting_team_id: 'EGY' },
      { phase: 'group', group_code: 'G', match_date: new Date('2026-06-27T03:00:00Z'), local_team_id: 'EGY', visiting_team_id: 'IRN' },
      { phase: 'group', group_code: 'G', match_date: new Date('2026-06-27T03:00:00Z'), local_team_id: 'NZL', visiting_team_id: 'BEL' },

      // ────────────── GROUP H ──────────────
      { phase: 'group', group_code: 'H', match_date: new Date('2026-06-15T16:00:00Z'), local_team_id: 'ESP', visiting_team_id: 'CPV' },
      { phase: 'group', group_code: 'H', match_date: new Date('2026-06-15T22:00:00Z'), local_team_id: 'SAU', visiting_team_id: 'URU' },
      { phase: 'group', group_code: 'H', match_date: new Date('2026-06-21T16:00:00Z'), local_team_id: 'ESP', visiting_team_id: 'SAU' },
      { phase: 'group', group_code: 'H', match_date: new Date('2026-06-21T22:00:00Z'), local_team_id: 'URU', visiting_team_id: 'CPV' },
      { phase: 'group', group_code: 'H', match_date: new Date('2026-06-27T00:00:00Z'), local_team_id: 'CPV', visiting_team_id: 'SAU' },
      { phase: 'group', group_code: 'H', match_date: new Date('2026-06-27T00:00:00Z'), local_team_id: 'URU', visiting_team_id: 'ESP' },

      // ────────────── GROUP I ──────────────
      { phase: 'group', group_code: 'I', match_date: new Date('2026-06-16T19:00:00Z'), local_team_id: 'FRA', visiting_team_id: 'SEN' },
      { phase: 'group', group_code: 'I', match_date: new Date('2026-06-16T22:00:00Z'), local_team_id: 'IRQ', visiting_team_id: 'NOR' },
      { phase: 'group', group_code: 'I', match_date: new Date('2026-06-22T21:00:00Z'), local_team_id: 'FRA', visiting_team_id: 'IRQ' },
      { phase: 'group', group_code: 'I', match_date: new Date('2026-06-23T00:00:00Z'), local_team_id: 'NOR', visiting_team_id: 'SEN' },
      { phase: 'group', group_code: 'I', match_date: new Date('2026-06-26T19:00:00Z'), local_team_id: 'NOR', visiting_team_id: 'FRA' },
      { phase: 'group', group_code: 'I', match_date: new Date('2026-06-26T19:00:00Z'), local_team_id: 'SEN', visiting_team_id: 'IRQ' },

      // ────────────── GROUP J ──────────────
      { phase: 'group', group_code: 'J', match_date: new Date('2026-06-17T01:00:00Z'), local_team_id: 'ARG', visiting_team_id: 'ALG' },
      { phase: 'group', group_code: 'J', match_date: new Date('2026-06-17T04:00:00Z'), local_team_id: 'AUT', visiting_team_id: 'JOR' },
      { phase: 'group', group_code: 'J', match_date: new Date('2026-06-22T17:00:00Z'), local_team_id: 'ARG', visiting_team_id: 'AUT' },
      { phase: 'group', group_code: 'J', match_date: new Date('2026-06-23T03:00:00Z'), local_team_id: 'JOR', visiting_team_id: 'ALG' },
      { phase: 'group', group_code: 'J', match_date: new Date('2026-06-28T02:00:00Z'), local_team_id: 'ALG', visiting_team_id: 'AUT' },
      { phase: 'group', group_code: 'J', match_date: new Date('2026-06-28T02:00:00Z'), local_team_id: 'JOR', visiting_team_id: 'ARG' },

      // ────────────── GROUP K ──────────────
      { phase: 'group', group_code: 'K', match_date: new Date('2026-06-17T17:00:00Z'), local_team_id: 'POR', visiting_team_id: 'COD' },
      { phase: 'group', group_code: 'K', match_date: new Date('2026-06-18T02:00:00Z'), local_team_id: 'UZB', visiting_team_id: 'COL' },
      { phase: 'group', group_code: 'K', match_date: new Date('2026-06-23T17:00:00Z'), local_team_id: 'POR', visiting_team_id: 'UZB' },
      { phase: 'group', group_code: 'K', match_date: new Date('2026-06-24T02:00:00Z'), local_team_id: 'COL', visiting_team_id: 'COD' },
      { phase: 'group', group_code: 'K', match_date: new Date('2026-06-27T23:30:00Z'), local_team_id: 'COL', visiting_team_id: 'POR' },
      { phase: 'group', group_code: 'K', match_date: new Date('2026-06-27T23:30:00Z'), local_team_id: 'COD', visiting_team_id: 'UZB' },

      // ────────────── GROUP L ──────────────
      { phase: 'group', group_code: 'L', match_date: new Date('2026-06-17T20:00:00Z'), local_team_id: 'ENG', visiting_team_id: 'CRO' },
      { phase: 'group', group_code: 'L', match_date: new Date('2026-06-17T23:00:00Z'), local_team_id: 'GHA', visiting_team_id: 'PAN' },
      { phase: 'group', group_code: 'L', match_date: new Date('2026-06-23T20:00:00Z'), local_team_id: 'ENG', visiting_team_id: 'GHA' },
      { phase: 'group', group_code: 'L', match_date: new Date('2026-06-23T23:00:00Z'), local_team_id: 'PAN', visiting_team_id: 'CRO' },
      { phase: 'group', group_code: 'L', match_date: new Date('2026-06-27T21:00:00Z'), local_team_id: 'PAN', visiting_team_id: 'ENG' },
      { phase: 'group', group_code: 'L', match_date: new Date('2026-06-27T21:00:00Z'), local_team_id: 'CRO', visiting_team_id: 'GHA' },

      // ════════════════════════════════════════════════════════════════════════
      // KNOCKOUT STAGE — teams TBD (null), dates from FIFA official schedule
      // ════════════════════════════════════════════════════════════════════════

      // ────────────── ROUND OF 32 (16 matches) ──────────────
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-06-28T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M73
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-06-29T20:30:00Z'), local_team_id: null, visiting_team_id: null },  // M74
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-06-29T17:00:00Z'), local_team_id: null, visiting_team_id: null },  // M76
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-06-30T01:00:00Z'), local_team_id: null, visiting_team_id: null },  // M75
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-06-30T21:00:00Z'), local_team_id: null, visiting_team_id: null },  // M77
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-06-30T17:00:00Z'), local_team_id: null, visiting_team_id: null },  // M78
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-01T01:00:00Z'), local_team_id: null, visiting_team_id: null },  // M79
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-01T16:00:00Z'), local_team_id: null, visiting_team_id: null },  // M80
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-01T20:00:00Z'), local_team_id: null, visiting_team_id: null },  // M82
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-02T00:00:00Z'), local_team_id: null, visiting_team_id: null },  // M81
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-02T23:00:00Z'), local_team_id: null, visiting_team_id: null },  // M83
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-02T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M84
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-03T03:00:00Z'), local_team_id: null, visiting_team_id: null },  // M85
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-03T22:00:00Z'), local_team_id: null, visiting_team_id: null },  // M86
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-03T18:00:00Z'), local_team_id: null, visiting_team_id: null },  // M88
      { phase: 'round_of_32', group_code: null, match_date: new Date('2026-07-04T01:30:00Z'), local_team_id: null, visiting_team_id: null },  // M87

      // ────────────── ROUND OF 16 (8 matches) ──────────────
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-04T21:00:00Z'), local_team_id: null, visiting_team_id: null },  // M89
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-04T17:00:00Z'), local_team_id: null, visiting_team_id: null },  // M90
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-05T20:00:00Z'), local_team_id: null, visiting_team_id: null },  // M91
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-06T00:00:00Z'), local_team_id: null, visiting_team_id: null },  // M92
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-06T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M93
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-07T00:00:00Z'), local_team_id: null, visiting_team_id: null },  // M94
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-07T16:00:00Z'), local_team_id: null, visiting_team_id: null },  // M95
      { phase: 'round_of_16', group_code: null, match_date: new Date('2026-07-07T20:00:00Z'), local_team_id: null, visiting_team_id: null },  // M96

      // ────────────── QUARTERFINALS (4 matches) ──────────────
      { phase: 'quarter', group_code: null, match_date: new Date('2026-07-09T20:00:00Z'), local_team_id: null, visiting_team_id: null },  // M97
      { phase: 'quarter', group_code: null, match_date: new Date('2026-07-10T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M98
      { phase: 'quarter', group_code: null, match_date: new Date('2026-07-11T21:00:00Z'), local_team_id: null, visiting_team_id: null },  // M99
      { phase: 'quarter', group_code: null, match_date: new Date('2026-07-12T01:00:00Z'), local_team_id: null, visiting_team_id: null },  // M100

      // ────────────── SEMIFINALS (2 matches) ──────────────
      { phase: 'semi', group_code: null, match_date: new Date('2026-07-14T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M101
      { phase: 'semi', group_code: null, match_date: new Date('2026-07-15T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M102

      // ────────────── THIRD PLACE ──────────────
      { phase: 'third_place', group_code: null, match_date: new Date('2026-07-18T21:00:00Z'), local_team_id: null, visiting_team_id: null },  // M103

      // ────────────── FINAL ──────────────
      { phase: 'final', group_code: null, match_date: new Date('2026-07-19T19:00:00Z'), local_team_id: null, visiting_team_id: null },  // M104
    ];

    await this.matchRepository.save(matches);

    // ── App Config ────────────────────────────────────────────────────────────
    const existingConfig = await this.configRepository.count();
    if (existingConfig === 0) {
      await this.configRepository.save([
        {
          key: 'podium_deadline',
          value: '2026-07-14T00:00:00Z',
          description: 'Fecha limite para modificar predicciones de podio (antes de semifinales)',
        },
      ]);
      this.logger.log('Seeded app_config with podium_deadline');
    }

    this.logger.log(`Seeded ${groups.length} groups, ${teams.length} teams, ${matches.length} matches`);
  }
}
