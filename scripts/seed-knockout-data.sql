-- =============================================================================
-- World Cup 2026 - Knockout Stage Data (R32 through Semifinals)
-- Results + Predictions + Points + Team assignments up to Final/3rd
-- =============================================================================

BEGIN;

-- ═══════════════════════════════════════════════════════════════════════════════
-- ROUND OF 32: Predictions for all 8 users
-- ═══════════════════════════════════════════════════════════════════════════════
-- Matches:
-- MEX vs SCO | MAR vs TUR | SUI vs CIV | KOR vs CAN
-- BRA vs SWE | ECU vs JPN | USA vs BIH | GER vs IRN
-- NED vs NOR | EGY vs URU | BEL vs GHA | ESP vs COD
-- SEN vs AUT | FRA vs COL | ARG vs CRO | POR vs ENG

-- ── admin_wc predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',2,0), ('MAR','TUR',1,0), ('SUI','CIV',1,1), ('KOR','CAN',0,1),
  ('BRA','SWE',3,0), ('ECU','JPN',0,2), ('USA','BIH',2,0), ('GER','IRN',3,0),
  ('NED','NOR',2,1), ('EGY','URU',0,2), ('BEL','GHA',2,0), ('ESP','COD',3,0),
  ('SEN','AUT',1,1), ('FRA','COL',2,1), ('ARG','CRO',2,0), ('POR','ENG',1,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'admin_wc'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── carlos_10 predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',3,0), ('MAR','TUR',1,1), ('SUI','CIV',2,0), ('KOR','CAN',1,0),
  ('BRA','SWE',4,0), ('ECU','JPN',1,2), ('USA','BIH',3,0), ('GER','IRN',4,0),
  ('NED','NOR',3,0), ('EGY','URU',0,3), ('BEL','GHA',2,1), ('ESP','COD',4,0),
  ('SEN','AUT',0,2), ('FRA','COL',3,1), ('ARG','CRO',3,0), ('POR','ENG',1,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'carlos_10'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── maria_fut predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',1,0), ('MAR','TUR',0,0), ('SUI','CIV',1,0), ('KOR','CAN',0,0),
  ('BRA','SWE',2,0), ('ECU','JPN',0,1), ('USA','BIH',1,0), ('GER','IRN',2,0),
  ('NED','NOR',1,0), ('EGY','URU',0,1), ('BEL','GHA',1,0), ('ESP','COD',2,0),
  ('SEN','AUT',1,0), ('FRA','COL',1,0), ('ARG','CRO',1,0), ('POR','ENG',0,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'maria_fut'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── juancho predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',2,1), ('MAR','TUR',2,2), ('SUI','CIV',1,2), ('KOR','CAN',2,1),
  ('BRA','SWE',3,1), ('ECU','JPN',2,3), ('USA','BIH',4,1), ('GER','IRN',3,1),
  ('NED','NOR',2,1), ('EGY','URU',1,3), ('BEL','GHA',3,1), ('ESP','COD',3,1),
  ('SEN','AUT',2,1), ('FRA','COL',2,2), ('ARG','CRO',4,1), ('POR','ENG',2,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'juancho'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── laura_gol predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',2,1), ('MAR','TUR',2,0), ('SUI','CIV',0,1), ('KOR','CAN',1,1),
  ('BRA','SWE',2,0), ('ECU','JPN',1,2), ('USA','BIH',2,0), ('GER','IRN',2,0),
  ('NED','NOR',1,0), ('EGY','URU',0,1), ('BEL','GHA',1,0), ('ESP','COD',2,0),
  ('SEN','AUT',0,1), ('FRA','COL',1,0), ('ARG','CRO',2,1), ('POR','ENG',1,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'laura_gol'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── pipe_crack predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',0,1), ('MAR','TUR',0,2), ('SUI','CIV',2,1), ('KOR','CAN',1,2),
  ('BRA','SWE',1,1), ('ECU','JPN',2,0), ('USA','BIH',1,1), ('GER','IRN',1,0),
  ('NED','NOR',0,0), ('EGY','URU',1,0), ('BEL','GHA',0,1), ('ESP','COD',1,0),
  ('SEN','AUT',1,0), ('FRA','COL',0,1), ('ARG','CRO',1,0), ('POR','ENG',0,0)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'pipe_crack'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── andrea_mun predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',1,0), ('MAR','TUR',1,1), ('SUI','CIV',1,0), ('KOR','CAN',1,1),
  ('BRA','SWE',2,1), ('ECU','JPN',1,1), ('USA','BIH',2,1), ('GER','IRN',2,0),
  ('NED','NOR',2,0), ('EGY','URU',1,2), ('BEL','GHA',2,0), ('ESP','COD',2,0),
  ('SEN','AUT',1,1), ('FRA','COL',1,0), ('ARG','CRO',1,0), ('POR','ENG',1,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'andrea_mun'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── sebas_pro predictions (R32) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','SCO',2,0), ('MAR','TUR',1,0), ('SUI','CIV',0,1), ('KOR','CAN',1,0),
  ('BRA','SWE',3,0), ('ECU','JPN',0,2), ('USA','BIH',2,0), ('GER','IRN',3,0),
  ('NED','NOR',2,0), ('EGY','URU',0,2), ('BEL','GHA',2,0), ('ESP','COD',3,0),
  ('SEN','AUT',0,1), ('FRA','COL',2,0), ('ARG','CRO',3,1), ('POR','ENG',1,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_32'
JOIN users u ON u.nickname = 'sebas_pro'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- ROUND OF 32: Results
-- ═══════════════════════════════════════════════════════════════════════════════
-- Winners advance to R16

UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='SCO' AND phase='round_of_32';   -- MEX advances
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='TUR' AND phase='round_of_32';   -- MAR advances
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='SUI' AND visiting_team_id='CIV' AND phase='round_of_32';   -- CIV advances (upset)
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='KOR' AND visiting_team_id='CAN' AND phase='round_of_32';   -- KOR advances
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='SWE' AND phase='round_of_32';   -- BRA advances
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='ECU' AND visiting_team_id='JPN' AND phase='round_of_32';   -- JPN advances
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='USA' AND visiting_team_id='BIH' AND phase='round_of_32';   -- USA advances
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='GER' AND visiting_team_id='IRN' AND phase='round_of_32';   -- GER advances
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='NED' AND visiting_team_id='NOR' AND phase='round_of_32';   -- NED advances
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='EGY' AND visiting_team_id='URU' AND phase='round_of_32';   -- URU advances
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='GHA' AND phase='round_of_32';   -- BEL advances
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='COD' AND phase='round_of_32';   -- ESP advances
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='SEN' AND visiting_team_id='AUT' AND phase='round_of_32';   -- AUT advances (upset)
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='COL' AND phase='round_of_32';   -- FRA advances
UPDATE matches SET local_result=3, visiting_result=1, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='CRO' AND phase='round_of_32';   -- ARG advances
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='POR' AND visiting_team_id='ENG' AND phase='round_of_32';   -- ENG advances

-- ═══════════════════════════════════════════════════════════════════════════════
-- ROUND OF 16: Assign teams (bracket pairing from R32 winners)
-- ═══════════════════════════════════════════════════════════════════════════════
-- R16-1: MEX vs MAR (winners of R32-1 and R32-2)
-- R16-2: CIV vs KOR (winners of R32-3 and R32-4)
-- R16-3: BRA vs JPN (winners of R32-5 and R32-6)
-- R16-4: USA vs GER (winners of R32-7 and R32-8)
-- R16-5: NED vs URU (winners of R32-9 and R32-10)
-- R16-6: BEL vs ESP (winners of R32-11 and R32-12)
-- R16-7: AUT vs FRA (winners of R32-13 and R32-14)
-- R16-8: ARG vs ENG (winners of R32-15 and R32-16)

UPDATE matches SET local_team_id='MEX', visiting_team_id='MAR' WHERE phase='round_of_16' AND match_date='2026-07-04 17:00:00';
UPDATE matches SET local_team_id='CIV', visiting_team_id='KOR' WHERE phase='round_of_16' AND match_date='2026-07-04 21:00:00';
UPDATE matches SET local_team_id='BRA', visiting_team_id='JPN' WHERE phase='round_of_16' AND match_date='2026-07-05 20:00:00';
UPDATE matches SET local_team_id='USA', visiting_team_id='GER' WHERE phase='round_of_16' AND match_date='2026-07-06 00:00:00';
UPDATE matches SET local_team_id='NED', visiting_team_id='URU' WHERE phase='round_of_16' AND match_date='2026-07-06 19:00:00';
UPDATE matches SET local_team_id='BEL', visiting_team_id='ESP' WHERE phase='round_of_16' AND match_date='2026-07-07 00:00:00';
UPDATE matches SET local_team_id='AUT', visiting_team_id='FRA' WHERE phase='round_of_16' AND match_date='2026-07-07 16:00:00';
UPDATE matches SET local_team_id='ARG', visiting_team_id='ENG' WHERE phase='round_of_16' AND match_date='2026-07-07 20:00:00';

-- ═══════════════════════════════════════════════════════════════════════════════
-- ROUND OF 16: Predictions
-- ═══════════════════════════════════════════════════════════════════════════════

-- ── admin_wc (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',1,2), ('CIV','KOR',0,1), ('BRA','JPN',2,1), ('USA','GER',1,2),
  ('NED','URU',1,0), ('BEL','ESP',0,2), ('AUT','FRA',0,3), ('ARG','ENG',2,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'admin_wc'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── carlos_10 (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',0,1), ('CIV','KOR',1,2), ('BRA','JPN',3,0), ('USA','GER',0,2),
  ('NED','URU',2,1), ('BEL','ESP',1,3), ('AUT','FRA',0,4), ('ARG','ENG',2,0)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'carlos_10'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── maria_fut (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',0,1), ('CIV','KOR',0,0), ('BRA','JPN',1,0), ('USA','GER',0,1),
  ('NED','URU',1,0), ('BEL','ESP',0,1), ('AUT','FRA',0,2), ('ARG','ENG',1,0)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'maria_fut'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── juancho (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',2,3), ('CIV','KOR',1,2), ('BRA','JPN',4,2), ('USA','GER',2,3),
  ('NED','URU',3,2), ('BEL','ESP',1,2), ('AUT','FRA',1,3), ('ARG','ENG',3,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'juancho'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── laura_gol (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',0,2), ('CIV','KOR',0,1), ('BRA','JPN',2,0), ('USA','GER',1,1),
  ('NED','URU',2,1), ('BEL','ESP',0,2), ('AUT','FRA',0,2), ('ARG','ENG',2,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'laura_gol'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── pipe_crack (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',1,0), ('CIV','KOR',2,0), ('BRA','JPN',1,1), ('USA','GER',2,1),
  ('NED','URU',0,1), ('BEL','ESP',1,1), ('AUT','FRA',1,0), ('ARG','ENG',0,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'pipe_crack'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── andrea_mun (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',1,1), ('CIV','KOR',1,0), ('BRA','JPN',2,0), ('USA','GER',1,2),
  ('NED','URU',1,1), ('BEL','ESP',1,2), ('AUT','FRA',0,1), ('ARG','ENG',1,0)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'andrea_mun'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── sebas_pro (R16) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MEX','MAR',0,1), ('CIV','KOR',0,1), ('BRA','JPN',2,1), ('USA','GER',0,2),
  ('NED','URU',1,0), ('BEL','ESP',0,2), ('AUT','FRA',1,3), ('ARG','ENG',2,0)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'round_of_16'
JOIN users u ON u.nickname = 'sebas_pro'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- ROUND OF 16: Results
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='MAR' AND phase='round_of_16';   -- MAR advances
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='CIV' AND visiting_team_id='KOR' AND phase='round_of_16';   -- KOR advances
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='JPN' AND phase='round_of_16';   -- BRA advances
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='USA' AND visiting_team_id='GER' AND phase='round_of_16';   -- GER advances
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='NED' AND visiting_team_id='URU' AND phase='round_of_16';   -- NED advances
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='ESP' AND phase='round_of_16';   -- ESP advances
UPDATE matches SET local_result=1, visiting_result=3, has_played=true WHERE local_team_id='AUT' AND visiting_team_id='FRA' AND phase='round_of_16';   -- FRA advances
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='ENG' AND phase='round_of_16';   -- ARG advances

-- ═══════════════════════════════════════════════════════════════════════════════
-- QUARTERFINALS: Assign teams
-- ═══════════════════════════════════════════════════════════════════════════════
-- QF1: MAR vs KOR (R16-1 winner vs R16-2 winner)
-- QF2: BRA vs GER (R16-3 winner vs R16-4 winner)
-- QF3: NED vs ESP (R16-5 winner vs R16-6 winner)
-- QF4: FRA vs ARG (R16-7 winner vs R16-8 winner)

UPDATE matches SET local_team_id='MAR', visiting_team_id='KOR' WHERE phase='quarter' AND match_date='2026-07-09 20:00:00';
UPDATE matches SET local_team_id='BRA', visiting_team_id='GER' WHERE phase='quarter' AND match_date='2026-07-10 19:00:00';
UPDATE matches SET local_team_id='NED', visiting_team_id='ESP' WHERE phase='quarter' AND match_date='2026-07-11 21:00:00';
UPDATE matches SET local_team_id='FRA', visiting_team_id='ARG' WHERE phase='quarter' AND match_date='2026-07-12 01:00:00';

-- ═══════════════════════════════════════════════════════════════════════════════
-- QUARTERFINALS: Predictions
-- ═══════════════════════════════════════════════════════════════════════════════

-- ── admin_wc (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',2,0), ('BRA','GER',1,2), ('NED','ESP',0,1), ('FRA','ARG',1,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'admin_wc'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── carlos_10 (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',1,0), ('BRA','GER',2,2), ('NED','ESP',1,2), ('FRA','ARG',1,3)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'carlos_10'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── maria_fut (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',1,0), ('BRA','GER',1,1), ('NED','ESP',0,1), ('FRA','ARG',0,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'maria_fut'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── juancho (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',2,1), ('BRA','GER',3,2), ('NED','ESP',2,3), ('FRA','ARG',2,3)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'juancho'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── laura_gol (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',1,0), ('BRA','GER',1,1), ('NED','ESP',1,2), ('FRA','ARG',1,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'laura_gol'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── pipe_crack (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',0,1), ('BRA','GER',0,1), ('NED','ESP',2,0), ('FRA','ARG',2,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'pipe_crack'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── andrea_mun (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',1,1), ('BRA','GER',2,1), ('NED','ESP',1,1), ('FRA','ARG',1,1)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'andrea_mun'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── sebas_pro (QF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES
  ('MAR','KOR',2,1), ('BRA','GER',1,2), ('NED','ESP',0,2), ('FRA','ARG',1,2)
) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'quarter'
JOIN users u ON u.nickname = 'sebas_pro'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- QUARTERFINALS: Results
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='KOR' AND phase='quarter';   -- MAR advances
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='GER' AND phase='quarter';   -- GER advances
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='NED' AND visiting_team_id='ESP' AND phase='quarter';   -- ESP advances
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='ARG' AND phase='quarter';   -- ARG advances

-- ═══════════════════════════════════════════════════════════════════════════════
-- SEMIFINALS: Assign teams
-- ═══════════════════════════════════════════════════════════════════════════════
-- SF1: MAR vs GER (QF1 winner vs QF2 winner)
-- SF2: ESP vs ARG (QF3 winner vs QF4 winner)

UPDATE matches SET local_team_id='MAR', visiting_team_id='GER' WHERE phase='semi' AND match_date='2026-07-14 19:00:00';
UPDATE matches SET local_team_id='ESP', visiting_team_id='ARG' WHERE phase='semi' AND match_date='2026-07-15 19:00:00';

-- ═══════════════════════════════════════════════════════════════════════════════
-- SEMIFINALS: Predictions
-- ═══════════════════════════════════════════════════════════════════════════════

-- ── admin_wc (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',0,2), ('ESP','ARG',1,2)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'admin_wc'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── carlos_10 (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',0,3), ('ESP','ARG',1,2)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'carlos_10'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── maria_fut (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',0,1), ('ESP','ARG',1,1)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'maria_fut'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── juancho (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',1,3), ('ESP','ARG',2,3)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'juancho'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── laura_gol (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',1,2), ('ESP','ARG',2,1)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'laura_gol'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── pipe_crack (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',1,0), ('ESP','ARG',2,0)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'pipe_crack'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── andrea_mun (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',1,1), ('ESP','ARG',1,2)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'andrea_mun'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ── sebas_pro (SF) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (VALUES ('MAR','GER',0,2), ('ESP','ARG',1,2)) AS p(lt, vt, ls, vs)
JOIN matches m ON m.local_team_id = p.lt AND m.visiting_team_id = p.vt AND m.phase = 'semi'
JOIN users u ON u.nickname = 'sebas_pro'
WHERE um.user_id = u.id AND um.match_id = m.id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- SEMIFINALS: Results
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='GER' AND phase='semi';   -- GER to Final
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='ARG' AND phase='semi';   -- ARG to Final

-- ═══════════════════════════════════════════════════════════════════════════════
-- FINAL & THIRD PLACE: Assign teams (NO results, NO predictions)
-- ═══════════════════════════════════════════════════════════════════════════════
-- Third place: MAR vs ESP (semifinal losers)
-- Final: GER vs ARG (semifinal winners)

UPDATE matches SET local_team_id='MAR', visiting_team_id='ESP' WHERE phase='third_place';
UPDATE matches SET local_team_id='GER', visiting_team_id='ARG' WHERE phase='final';

-- ═══════════════════════════════════════════════════════════════════════════════
-- RECALCULATE ALL KNOCKOUT POINTS
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE user_matches um SET
  points = sub.total,
  discriminated_points = jsonb_build_object(
    'resultPoints', sub.result_pts,
    'localScorePoints', sub.local_pts,
    'visitorScorePoints', sub.visitor_pts,
    'exactScoreBonus', sub.exact_pts,
    'drawBonus', sub.draw_pts
  )
FROM (
  SELECT
    um2.id as um_id,
    CASE WHEN sign(um2.local_score - um2.visitor_score) = sign(m.local_result - m.visiting_result) THEN 2 ELSE 0 END as result_pts,
    CASE WHEN um2.local_score = m.local_result THEN 1 ELSE 0 END as local_pts,
    CASE WHEN um2.visitor_score = m.visiting_result THEN 1 ELSE 0 END as visitor_pts,
    CASE WHEN um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result THEN 3 ELSE 0 END as exact_pts,
    CASE WHEN um2.local_score = um2.visitor_score AND m.local_result = m.visiting_result
              AND NOT (um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result) THEN 1 ELSE 0 END as draw_pts,
    CASE WHEN sign(um2.local_score - um2.visitor_score) = sign(m.local_result - m.visiting_result) THEN 2 ELSE 0 END
    + CASE WHEN um2.local_score = m.local_result THEN 1 ELSE 0 END
    + CASE WHEN um2.visitor_score = m.visiting_result THEN 1 ELSE 0 END
    + CASE WHEN um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result THEN 3 ELSE 0 END
    + CASE WHEN um2.local_score = um2.visitor_score AND m.local_result = m.visiting_result
                AND NOT (um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result) THEN 1 ELSE 0 END
    as total
  FROM user_matches um2
  JOIN matches m ON m.id = um2.match_id
  WHERE m.phase IN ('round_of_32','round_of_16','quarter','semi')
    AND m.has_played = true
    AND um2.local_score IS NOT NULL AND um2.visitor_score IS NOT NULL
) sub
WHERE um.id = sub.um_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- RECALCULATE USER TOTAL SCORES (groups + knockout)
-- ═══════════════════════════════════════════════════════════════════════════════

UPDATE users u SET score = coalesce(sub.total_points, 0)
FROM (
  SELECT um.user_id, SUM(um.points) as total_points
  FROM user_matches um
  JOIN matches m ON m.id = um.match_id
  WHERE m.has_played = true
  GROUP BY um.user_id
) sub
WHERE u.id = sub.user_id;

COMMIT;
