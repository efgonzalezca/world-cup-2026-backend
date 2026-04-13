-- =============================================================================
-- World Cup 2026 - Full Test Data for Global Compose
-- Resets existing data, creates users, group stage + knockout through SF
-- Argentina eliminated in SF. Final: GER vs ESP. 3rd: MAR vs ARG.
-- =============================================================================

BEGIN;

-- ═══════════════════════════════════════════════════════════════════════════════
-- 0. RESET existing match data
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE matches SET local_result = NULL, visiting_result = NULL, has_played = false;
UPDATE matches SET local_team_id = NULL, visiting_team_id = NULL
  WHERE phase IN ('round_of_32','round_of_16','quarter','semi','third_place','final');
UPDATE user_matches SET local_score = NULL, visitor_score = NULL, points = 0, discriminated_points = NULL;
UPDATE users SET score = 0, podium_score = 0;

-- ═══════════════════════════════════════════════════════════════════════════════
-- 1. GROUP STAGE RESULTS (72 matches)
-- ═══════════════════════════════════════════════════════════════════════════════

-- GROUP A: MEX(9), KOR(4), CZE(2), RSA(1)
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='RSA' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='KOR' AND visiting_team_id='CZE' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=0, has_played=true WHERE local_team_id='CZE' AND visiting_team_id='RSA' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='KOR' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='CZE' AND visiting_team_id='MEX' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='RSA' AND visiting_team_id='KOR' AND phase='group';

-- GROUP B: SUI(7), CAN(7), BIH(3), QAT(0)
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='CAN' AND visiting_team_id='BIH' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='QAT' AND visiting_team_id='SUI' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='SUI' AND visiting_team_id='BIH' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='CAN' AND visiting_team_id='QAT' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='SUI' AND visiting_team_id='CAN' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='BIH' AND visiting_team_id='QAT' AND phase='group';

-- GROUP C: BRA(7), MAR(7), SCO(3), HAI(0)
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='MAR' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='HAI' AND visiting_team_id='SCO' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='SCO' AND visiting_team_id='MAR' AND phase='group';
UPDATE matches SET local_result=4, visiting_result=0, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='HAI' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='SCO' AND visiting_team_id='BRA' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='HAI' AND phase='group';

-- GROUP D: USA(9), TUR(4), PAR(2), AUS(1)
UPDATE matches SET local_result=3, visiting_result=1, has_played=true WHERE local_team_id='USA' AND visiting_team_id='PAR' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='AUS' AND visiting_team_id='TUR' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='USA' AND visiting_team_id='AUS' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='TUR' AND visiting_team_id='PAR' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='TUR' AND visiting_team_id='USA' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=2, has_played=true WHERE local_team_id='PAR' AND visiting_team_id='AUS' AND phase='group';

-- GROUP E: GER(9), ECU(4), CIV(4), CUW(0)
UPDATE matches SET local_result=5, visiting_result=0, has_played=true WHERE local_team_id='GER' AND visiting_team_id='CUW' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='CIV' AND visiting_team_id='ECU' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='GER' AND visiting_team_id='CIV' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ECU' AND visiting_team_id='CUW' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='ECU' AND visiting_team_id='GER' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=4, has_played=true WHERE local_team_id='CUW' AND visiting_team_id='CIV' AND phase='group';

-- GROUP F: NED(9), JPN(6), SWE(3), TUN(0)
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='NED' AND visiting_team_id='JPN' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='SWE' AND visiting_team_id='TUN' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=1, has_played=true WHERE local_team_id='NED' AND visiting_team_id='SWE' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='TUN' AND visiting_team_id='JPN' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='JPN' AND visiting_team_id='SWE' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='TUN' AND visiting_team_id='NED' AND phase='group';

-- GROUP G: BEL(7), EGY(6), IRN(4), NZL(0)
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='EGY' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='IRN' AND visiting_team_id='NZL' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='IRN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='NZL' AND visiting_team_id='EGY' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='EGY' AND visiting_team_id='IRN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='NZL' AND visiting_team_id='BEL' AND phase='group';

-- GROUP H: ESP(7), URU(7), CPV(1), SAU(1)
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='CPV' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='SAU' AND visiting_team_id='URU' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='SAU' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='URU' AND visiting_team_id='CPV' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='CPV' AND visiting_team_id='SAU' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='URU' AND visiting_team_id='ESP' AND phase='group';

-- GROUP I: FRA(9), SEN(4), NOR(4), IRQ(0)
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='SEN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='IRQ' AND visiting_team_id='NOR' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='IRQ' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='NOR' AND visiting_team_id='SEN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='NOR' AND visiting_team_id='FRA' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='SEN' AND visiting_team_id='IRQ' AND phase='group';

-- GROUP J: ARG(9), AUT(4), JOR(3), ALG(1)
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='ALG' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='AUT' AND visiting_team_id='JOR' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='AUT' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='JOR' AND visiting_team_id='ALG' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='ALG' AND visiting_team_id='AUT' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=4, has_played=true WHERE local_team_id='JOR' AND visiting_team_id='ARG' AND phase='group';

-- GROUP K: POR(7), COL(7), COD(3), UZB(0)
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='POR' AND visiting_team_id='COD' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='UZB' AND visiting_team_id='COL' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='POR' AND visiting_team_id='UZB' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='COL' AND visiting_team_id='COD' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='COL' AND visiting_team_id='POR' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='COD' AND visiting_team_id='UZB' AND phase='group';

-- GROUP L: ENG(9), CRO(4), GHA(4), PAN(0)
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='ENG' AND visiting_team_id='CRO' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='GHA' AND visiting_team_id='PAN' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='ENG' AND visiting_team_id='GHA' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='PAN' AND visiting_team_id='CRO' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='PAN' AND visiting_team_id='ENG' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='CRO' AND visiting_team_id='GHA' AND phase='group';

-- ═══════════════════════════════════════════════════════════════════════════════
-- 2. R32 TEAM ASSIGNMENTS
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE matches SET local_team_id='MEX', visiting_team_id='SCO' WHERE phase='round_of_32' AND match_date='2026-06-28 19:00:00';
UPDATE matches SET local_team_id='MAR', visiting_team_id='TUR' WHERE phase='round_of_32' AND match_date='2026-06-29 17:00:00';
UPDATE matches SET local_team_id='SUI', visiting_team_id='CIV' WHERE phase='round_of_32' AND match_date='2026-06-29 20:30:00';
UPDATE matches SET local_team_id='KOR', visiting_team_id='CAN' WHERE phase='round_of_32' AND match_date='2026-06-30 01:00:00';
UPDATE matches SET local_team_id='BRA', visiting_team_id='SWE' WHERE phase='round_of_32' AND match_date='2026-06-30 17:00:00';
UPDATE matches SET local_team_id='ECU', visiting_team_id='JPN' WHERE phase='round_of_32' AND match_date='2026-06-30 21:00:00';
UPDATE matches SET local_team_id='USA', visiting_team_id='BIH' WHERE phase='round_of_32' AND match_date='2026-07-01 01:00:00';
UPDATE matches SET local_team_id='GER', visiting_team_id='IRN' WHERE phase='round_of_32' AND match_date='2026-07-01 16:00:00';
UPDATE matches SET local_team_id='NED', visiting_team_id='NOR' WHERE phase='round_of_32' AND match_date='2026-07-01 20:00:00';
UPDATE matches SET local_team_id='EGY', visiting_team_id='URU' WHERE phase='round_of_32' AND match_date='2026-07-02 00:00:00';
UPDATE matches SET local_team_id='BEL', visiting_team_id='GHA' WHERE phase='round_of_32' AND match_date='2026-07-02 19:00:00';
UPDATE matches SET local_team_id='ESP', visiting_team_id='COD' WHERE phase='round_of_32' AND match_date='2026-07-02 23:00:00';
UPDATE matches SET local_team_id='SEN', visiting_team_id='AUT' WHERE phase='round_of_32' AND match_date='2026-07-03 03:00:00';
UPDATE matches SET local_team_id='FRA', visiting_team_id='COL' WHERE phase='round_of_32' AND match_date='2026-07-03 18:00:00';
UPDATE matches SET local_team_id='ARG', visiting_team_id='CRO' WHERE phase='round_of_32' AND match_date='2026-07-03 22:00:00';
UPDATE matches SET local_team_id='POR', visiting_team_id='ENG' WHERE phase='round_of_32' AND match_date='2026-07-04 01:30:00';

-- R32 RESULTS
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='SCO' AND phase='round_of_32';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='TUR' AND phase='round_of_32';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='SUI' AND visiting_team_id='CIV' AND phase='round_of_32';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='KOR' AND visiting_team_id='CAN' AND phase='round_of_32';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='SWE' AND phase='round_of_32';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='ECU' AND visiting_team_id='JPN' AND phase='round_of_32';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='USA' AND visiting_team_id='BIH' AND phase='round_of_32';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='GER' AND visiting_team_id='IRN' AND phase='round_of_32';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='NED' AND visiting_team_id='NOR' AND phase='round_of_32';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='EGY' AND visiting_team_id='URU' AND phase='round_of_32';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='GHA' AND phase='round_of_32';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='COD' AND phase='round_of_32';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='SEN' AND visiting_team_id='AUT' AND phase='round_of_32';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='COL' AND phase='round_of_32';
UPDATE matches SET local_result=3, visiting_result=1, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='CRO' AND phase='round_of_32';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='POR' AND visiting_team_id='ENG' AND phase='round_of_32';

-- ═══════════════════════════════════════════════════════════════════════════════
-- 3. R16 TEAM ASSIGNMENTS + RESULTS
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE matches SET local_team_id='MEX', visiting_team_id='MAR' WHERE phase='round_of_16' AND match_date='2026-07-04 17:00:00';
UPDATE matches SET local_team_id='CIV', visiting_team_id='KOR' WHERE phase='round_of_16' AND match_date='2026-07-04 21:00:00';
UPDATE matches SET local_team_id='BRA', visiting_team_id='JPN' WHERE phase='round_of_16' AND match_date='2026-07-05 20:00:00';
UPDATE matches SET local_team_id='USA', visiting_team_id='GER' WHERE phase='round_of_16' AND match_date='2026-07-06 00:00:00';
UPDATE matches SET local_team_id='NED', visiting_team_id='URU' WHERE phase='round_of_16' AND match_date='2026-07-06 19:00:00';
UPDATE matches SET local_team_id='BEL', visiting_team_id='ESP' WHERE phase='round_of_16' AND match_date='2026-07-07 00:00:00';
UPDATE matches SET local_team_id='AUT', visiting_team_id='FRA' WHERE phase='round_of_16' AND match_date='2026-07-07 16:00:00';
UPDATE matches SET local_team_id='ARG', visiting_team_id='ENG' WHERE phase='round_of_16' AND match_date='2026-07-07 20:00:00';

UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='MAR' AND phase='round_of_16';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='CIV' AND visiting_team_id='KOR' AND phase='round_of_16';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='JPN' AND phase='round_of_16';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='USA' AND visiting_team_id='GER' AND phase='round_of_16';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='NED' AND visiting_team_id='URU' AND phase='round_of_16';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='ESP' AND phase='round_of_16';
UPDATE matches SET local_result=1, visiting_result=3, has_played=true WHERE local_team_id='AUT' AND visiting_team_id='FRA' AND phase='round_of_16';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='ENG' AND phase='round_of_16';

-- ═══════════════════════════════════════════════════════════════════════════════
-- 4. QUARTERFINALS TEAM ASSIGNMENTS + RESULTS
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE matches SET local_team_id='MAR', visiting_team_id='KOR' WHERE phase='quarter' AND match_date='2026-07-09 20:00:00';
UPDATE matches SET local_team_id='BRA', visiting_team_id='GER' WHERE phase='quarter' AND match_date='2026-07-10 19:00:00';
UPDATE matches SET local_team_id='NED', visiting_team_id='ESP' WHERE phase='quarter' AND match_date='2026-07-11 21:00:00';
UPDATE matches SET local_team_id='FRA', visiting_team_id='ARG' WHERE phase='quarter' AND match_date='2026-07-12 01:00:00';

UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='KOR' AND phase='quarter';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='GER' AND phase='quarter';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='NED' AND visiting_team_id='ESP' AND phase='quarter';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='ARG' AND phase='quarter';

-- ═══════════════════════════════════════════════════════════════════════════════
-- 5. SEMIFINALS TEAM ASSIGNMENTS + RESULTS
-- ═══════════════════════════════════════════════════════════════════════════════
-- SF1: MAR vs GER
-- SF2: ESP vs ARG -> ESP wins! ARG eliminated

UPDATE matches SET local_team_id='MAR', visiting_team_id='GER' WHERE phase='semi' AND match_date='2026-07-14 19:00:00';
UPDATE matches SET local_team_id='ESP', visiting_team_id='ARG' WHERE phase='semi' AND match_date='2026-07-15 19:00:00';

UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='GER' AND phase='semi';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='ARG' AND phase='semi';

-- ═══════════════════════════════════════════════════════════════════════════════
-- 6. FINAL & 3RD PLACE: Assign teams only (no results)
-- ═══════════════════════════════════════════════════════════════════════════════
-- 3rd place: MAR vs ARG (losers)
-- Final: GER vs ESP (winners)
UPDATE matches SET local_team_id='MAR', visiting_team_id='ARG' WHERE phase='third_place';
UPDATE matches SET local_team_id='GER', visiting_team_id='ESP' WHERE phase='final';

-- ═══════════════════════════════════════════════════════════════════════════════
-- 7. USER PREDICTIONS: All phases for both existing users + new ones
-- ═══════════════════════════════════════════════════════════════════════════════

-- Helper: all played matches with results
CREATE TEMP TABLE mr AS
SELECT m.id as match_id, m.local_team_id as lt, m.visiting_team_id as vt,
       m.local_result as lr, m.visiting_result as vr, m.phase
FROM matches m WHERE m.has_played = true;

-- ── Efrain (admin): Good predictor, favors big teams ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      -- Group A
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 2 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 0 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0
      -- Group B
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 2 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 2
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 2
      -- Group C
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 4
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 3
      -- Group D
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 3 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 2 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 2
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      -- Group E
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 5 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 2 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 3
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      -- Group F
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 2 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 3 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      -- Group G
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 2 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      -- Group H
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 3 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      -- Group I
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 2 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 3 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 2
      -- Group J
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 3 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      -- Group K
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 2 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 3 WHEN mr.lt='COL' AND mr.vt='COD' THEN 2
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      -- Group L
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 2
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 2 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      -- R32
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 2 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 3 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='USA' AND mr.vt='BIH' THEN 2 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 3
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 2 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 2 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 3
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 1 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 3 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 1
      -- R16
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 1 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 2 WHEN mr.lt='USA' AND mr.vt='GER' THEN 1
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 1 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 0
      WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 0 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 2
      -- QF
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 1
      WHEN mr.lt='NED' AND mr.vt='ESP' THEN 0 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 1
      -- SF
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 0 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 1
      ELSE 1 END as ls,
    CASE
      -- Group A
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 2
      -- Group B
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      -- Group C
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 0 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 3 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      -- Group D
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 0
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      -- Group E
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 4
      -- Group F
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      -- Group G
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 3
      -- Group H
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      -- Group I
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      -- Group J
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 4
      -- Group K
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      -- Group L
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 3
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 2 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      -- R32
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 0 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 0 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='USA' AND mr.vt='BIH' THEN 0 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 0 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 2
      WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 0 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 0
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 1 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 1
      -- R16
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 2 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 1 WHEN mr.lt='USA' AND mr.vt='GER' THEN 2
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 0 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 3 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 0
      -- QF
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 2
      WHEN mr.lt='NED' AND mr.vt='ESP' THEN 2 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 2
      -- SF
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 2 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 2
      ELSE 0 END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'Efrain'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── daren: Conservative predictor (low scores, lots of 1-0) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 0 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 0 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 1
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 3 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 2
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 0 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 2 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 2 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 2 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 1 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 2 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 0 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      -- R32
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 1 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 2 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='USA' AND mr.vt='BIH' THEN 1 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 1 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 1 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 2
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 1 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 2 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 0
      -- R16
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 0 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 1 WHEN mr.lt='USA' AND mr.vt='GER' THEN 0
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 1 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 0
      WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 0 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 1
      -- QF
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 1
      WHEN mr.lt='NED' AND mr.vt='ESP' THEN 1 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 0
      -- SF
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 0 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 1
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 1 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 0 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 0 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 1 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 0 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 0
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 0 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 2
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 0 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 0 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 1 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 2
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 0
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 0 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 1
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 1 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 0
      -- R32
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 0 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 0 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='USA' AND mr.vt='BIH' THEN 0 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 0 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 0 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 0
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 0 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 1
      -- R16
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 1 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 0 WHEN mr.lt='USA' AND mr.vt='GER' THEN 1
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 0 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 1 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 0
      -- QF
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 1
      WHEN mr.lt='NED' AND mr.vt='ESP' THEN 0 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 1
      -- SF
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 1 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 0
      ELSE 0 END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'daren'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- 8. CALCULATE ALL POINTS
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
  WHERE m.has_played = true
    AND um2.local_score IS NOT NULL AND um2.visitor_score IS NOT NULL
) sub
WHERE um.id = sub.um_id;

-- Update user totals
UPDATE users u SET score = coalesce(sub.total_points, 0)
FROM (
  SELECT um.user_id, SUM(um.points) as total_points
  FROM user_matches um
  JOIN matches m ON m.id = um.match_id
  WHERE m.has_played = true
  GROUP BY um.user_id
) sub
WHERE u.id = sub.user_id;

-- Clean up
DROP TABLE IF EXISTS mr;

COMMIT;
