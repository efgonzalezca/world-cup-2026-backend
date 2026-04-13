-- =============================================================================
-- World Cup 2026 - Test Data Ingestion
-- Grupo stage results + user predictions + round of 32 assignment
-- =============================================================================

BEGIN;

-- ─── 1. GROUP STAGE RESULTS (72 matches) ────────────────────────────────────
-- Realistic results for all group stage matches

-- GROUP A: MEX(9pts), KOR(4pts), CZE(2pts), RSA(1pt)
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='RSA' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='KOR' AND visiting_team_id='CZE' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=0, has_played=true WHERE local_team_id='CZE' AND visiting_team_id='RSA' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='MEX' AND visiting_team_id='KOR' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='CZE' AND visiting_team_id='MEX' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='RSA' AND visiting_team_id='KOR' AND phase='group';

-- GROUP B: SUI(7pts), CAN(7pts), BIH(3pts), QAT(0pts)
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='CAN' AND visiting_team_id='BIH' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='QAT' AND visiting_team_id='SUI' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='SUI' AND visiting_team_id='BIH' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='CAN' AND visiting_team_id='QAT' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='SUI' AND visiting_team_id='CAN' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='BIH' AND visiting_team_id='QAT' AND phase='group';

-- GROUP C: BRA(7pts), MAR(7pts), SCO(3pts), HAI(0pts)
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='MAR' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='HAI' AND visiting_team_id='SCO' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='SCO' AND visiting_team_id='MAR' AND phase='group';
UPDATE matches SET local_result=4, visiting_result=0, has_played=true WHERE local_team_id='BRA' AND visiting_team_id='HAI' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='SCO' AND visiting_team_id='BRA' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='MAR' AND visiting_team_id='HAI' AND phase='group';

-- GROUP D: USA(9pts), TUR(4pts), PAR(2pts), AUS(1pt)
UPDATE matches SET local_result=3, visiting_result=1, has_played=true WHERE local_team_id='USA' AND visiting_team_id='PAR' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='AUS' AND visiting_team_id='TUR' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='USA' AND visiting_team_id='AUS' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='TUR' AND visiting_team_id='PAR' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='TUR' AND visiting_team_id='USA' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=2, has_played=true WHERE local_team_id='PAR' AND visiting_team_id='AUS' AND phase='group';

-- GROUP E: GER(9pts), ECU(4pts), CIV(4pts), CUW(0pts)
UPDATE matches SET local_result=5, visiting_result=0, has_played=true WHERE local_team_id='GER' AND visiting_team_id='CUW' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='CIV' AND visiting_team_id='ECU' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='GER' AND visiting_team_id='CIV' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ECU' AND visiting_team_id='CUW' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=2, has_played=true WHERE local_team_id='ECU' AND visiting_team_id='GER' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=4, has_played=true WHERE local_team_id='CUW' AND visiting_team_id='CIV' AND phase='group';

-- GROUP F: NED(9pts), JPN(6pts), SWE(3pts), TUN(0pts)
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='NED' AND visiting_team_id='JPN' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='SWE' AND visiting_team_id='TUN' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=1, has_played=true WHERE local_team_id='NED' AND visiting_team_id='SWE' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='TUN' AND visiting_team_id='JPN' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='JPN' AND visiting_team_id='SWE' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='TUN' AND visiting_team_id='NED' AND phase='group';

-- GROUP G: BEL(7pts), EGY(6pts), IRN(4pts), NZL(0pts)
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='EGY' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='IRN' AND visiting_team_id='NZL' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='BEL' AND visiting_team_id='IRN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='NZL' AND visiting_team_id='EGY' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='EGY' AND visiting_team_id='IRN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='NZL' AND visiting_team_id='BEL' AND phase='group';

-- GROUP H: ESP(7pts), URU(7pts), CPV(1pt), SAU(1pt)
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='CPV' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='SAU' AND visiting_team_id='URU' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='ESP' AND visiting_team_id='SAU' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='URU' AND visiting_team_id='CPV' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='CPV' AND visiting_team_id='SAU' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='URU' AND visiting_team_id='ESP' AND phase='group';

-- GROUP I: FRA(9pts), SEN(4pts), NOR(4pts), IRQ(0pts)
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='SEN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='IRQ' AND visiting_team_id='NOR' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='FRA' AND visiting_team_id='IRQ' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='NOR' AND visiting_team_id='SEN' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='NOR' AND visiting_team_id='FRA' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='SEN' AND visiting_team_id='IRQ' AND phase='group';

-- GROUP J: ARG(9pts), AUT(4pts), JOR(3pts), ALG(1pt)
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='ALG' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='AUT' AND visiting_team_id='JOR' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='ARG' AND visiting_team_id='AUT' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='JOR' AND visiting_team_id='ALG' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='ALG' AND visiting_team_id='AUT' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=4, has_played=true WHERE local_team_id='JOR' AND visiting_team_id='ARG' AND phase='group';

-- GROUP K: POR(7pts), COL(7pts), COD(3pts), UZB(0pts)
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='POR' AND visiting_team_id='COD' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=1, has_played=true WHERE local_team_id='UZB' AND visiting_team_id='COL' AND phase='group';
UPDATE matches SET local_result=3, visiting_result=0, has_played=true WHERE local_team_id='POR' AND visiting_team_id='UZB' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='COL' AND visiting_team_id='COD' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='COL' AND visiting_team_id='POR' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='COD' AND visiting_team_id='UZB' AND phase='group';

-- GROUP L: ENG(9pts), CRO(4pts), GHA(4pts), PAN(0pts)
UPDATE matches SET local_result=1, visiting_result=0, has_played=true WHERE local_team_id='ENG' AND visiting_team_id='CRO' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=1, has_played=true WHERE local_team_id='GHA' AND visiting_team_id='PAN' AND phase='group';
UPDATE matches SET local_result=2, visiting_result=0, has_played=true WHERE local_team_id='ENG' AND visiting_team_id='GHA' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=3, has_played=true WHERE local_team_id='PAN' AND visiting_team_id='CRO' AND phase='group';
UPDATE matches SET local_result=0, visiting_result=2, has_played=true WHERE local_team_id='PAN' AND visiting_team_id='ENG' AND phase='group';
UPDATE matches SET local_result=1, visiting_result=1, has_played=true WHERE local_team_id='CRO' AND visiting_team_id='GHA' AND phase='group';

-- ─── 2. USER PREDICTIONS ────────────────────────────────────────────────────
-- Each user has different prediction styles

-- Helper: Create temp table with match results for easier joining
CREATE TEMP TABLE match_results AS
SELECT m.id as match_id, m.local_team_id as lt, m.visiting_team_id as vt,
       m.local_result as lr, m.visiting_result as vr
FROM matches m WHERE m.phase = 'group' AND m.has_played = true;

-- ── admin_wc: Balanced predictor (decent overall) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 0 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 2 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 2 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 3
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 1 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 2
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 2 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 2
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 4 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 2 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 2
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 0 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 2
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 3 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 2
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 2 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 3 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 2 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 2 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 2 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 2
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 2 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 2
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 2
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 0 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 0 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 0 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 2 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 0 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 0
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 2 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 0
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 3
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 3
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 0
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 2
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 1 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 0
      ELSE 0 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'admin_wc'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── carlos_10: Favors big teams (overestimates favorites) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 3 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 0 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 3 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 2
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 2 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 3 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 4
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 3
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 3 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 2 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 2
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 5 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 3 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 3
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 0 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 2 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 3 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 2 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 4 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 3 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 3
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 3 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 4 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 2
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 3 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 3 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 3 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 4 WHEN mr.lt='COL' AND mr.vt='COD' THEN 2
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 0 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 2 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 3 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 2
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 3 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 0 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 3
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 3 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 0
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 2 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 0
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 0 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 3 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 2
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 3
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 2
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 3
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 0 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 0
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 3 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 4
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 2
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 2 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 2
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 3 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 0
      ELSE 0 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'carlos_10'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── maria_fut: Conservative (lots of 1-0, 0-0, low scores) ──
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
      ELSE 0 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'maria_fut'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── juancho: Chaotic (high-scoring predictions, lots of goals) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 3 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 2 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 3
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 2 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 3 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 4
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 2 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 3
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 5
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 1 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 4
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 2 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 3 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 2
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 6 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 3 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 4
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 1
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 3 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 3 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 3 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 2
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 4 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 3 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 2
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 3 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 4 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 2
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 1 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 3
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 4 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 3
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 3 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 2
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 1
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 3 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 4 WHEN mr.lt='COL' AND mr.vt='COD' THEN 3
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 2 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 2
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 2 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 3
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 3 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 1
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 1 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 2
      ELSE 2 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 3 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 3
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 2 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 2 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 3 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 1
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 2 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 1 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 1
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 3 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 3
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 2 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 3
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 3
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 2
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 4
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 1 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 3
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 1 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 1 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 5
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 1 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 2
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 1 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 2 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 2
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 3 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      ELSE 1 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'juancho'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── laura_gol: Good predictor (many close to real results) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 2 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 1 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 2 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 2
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 2
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 3
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 2
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 3 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 2 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 4 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 2 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 3
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 2 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 2 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 3 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 2 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 3 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 3 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 2 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 3 WHEN mr.lt='COL' AND mr.vt='COD' THEN 2
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 2
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 2 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 3 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 4
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 3
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 4
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 3
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 2 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      ELSE 0 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'laura_gol'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── pipe_crack: Mediocre (random-ish, some right some very wrong) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 2 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 0 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 0 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 2 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 1
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 0
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 2 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 0
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 3 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 0
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 1
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 1
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 2 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 2 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 0
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 1 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 2 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 1
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 1 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 2 WHEN mr.lt='COL' AND mr.vt='COD' THEN 0
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 0 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 1
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 1 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 0
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 1 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 0 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 0 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 1 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 0 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 0 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 2
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      ELSE 0 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'pipe_crack'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── andrea_mun: Decent (favors draws and close games) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 1 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 2 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 2 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 3
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 1 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 2
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 2 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 2
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 4 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 2
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 2
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 2 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 3 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 2
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 2 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 2 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 2
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 1 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 2 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 3 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 2 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 2
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 2 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 2
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 2
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 2 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 0 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 0
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 3
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 2
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 0 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 2
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 3
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 2
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 0
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 1
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 2 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 0
      ELSE 1 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'andrea_mun'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ── sebas_pro: Expert predictor (highest accuracy, many exact scores) ──
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 2 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 1 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 2 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 2
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 2
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 4
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 3
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 3 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 2 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 5 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 2 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 3
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 2 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 3 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 2 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 3 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 2 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 3 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 3 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 2
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 2 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 3 WHEN mr.lt='COL' AND mr.vt='COD' THEN 2
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 2
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 2 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 1 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 3 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1
      WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 4
      WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 3
      WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 2
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0
      WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0
      WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 4
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1
      WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 1 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 3
      WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 2 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      ELSE 0 END as vs
  FROM match_results mr
) p
JOIN users u ON u.nickname = 'sebas_pro'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ─── 3. CALCULATE POINTS ────────────────────────────────────────────────────
-- Apply scoring logic: result(2) + local_goal(1) + visitor_goal(1) + exact(3) + draw_bonus(1)

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
    -- Result points (2 if correct W/D/L)
    CASE WHEN sign(um2.local_score - um2.visitor_score) = sign(m.local_result - m.visiting_result) THEN 2 ELSE 0 END as result_pts,
    -- Local score points (1 if exact local goals)
    CASE WHEN um2.local_score = m.local_result THEN 1 ELSE 0 END as local_pts,
    -- Visitor score points (1 if exact visitor goals)
    CASE WHEN um2.visitor_score = m.visiting_result THEN 1 ELSE 0 END as visitor_pts,
    -- Exact score bonus (3 if both goals match)
    CASE WHEN um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result THEN 3 ELSE 0 END as exact_pts,
    -- Draw bonus (1 if both draw but not exact)
    CASE WHEN um2.local_score = um2.visitor_score AND m.local_result = m.visiting_result
              AND NOT (um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result) THEN 1 ELSE 0 END as draw_pts,
    -- Total
    CASE WHEN sign(um2.local_score - um2.visitor_score) = sign(m.local_result - m.visiting_result) THEN 2 ELSE 0 END
    + CASE WHEN um2.local_score = m.local_result THEN 1 ELSE 0 END
    + CASE WHEN um2.visitor_score = m.visiting_result THEN 1 ELSE 0 END
    + CASE WHEN um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result THEN 3 ELSE 0 END
    + CASE WHEN um2.local_score = um2.visitor_score AND m.local_result = m.visiting_result
                AND NOT (um2.local_score = m.local_result AND um2.visitor_score = m.visiting_result) THEN 1 ELSE 0 END
    as total
  FROM user_matches um2
  JOIN matches m ON m.id = um2.match_id
  WHERE m.phase = 'group' AND m.has_played = true
    AND um2.local_score IS NOT NULL AND um2.visitor_score IS NOT NULL
) sub
WHERE um.id = sub.um_id;

-- ─── 4. UPDATE USER TOTAL SCORES ────────────────────────────────────────────
UPDATE users u SET score = coalesce(sub.total_points, 0)
FROM (
  SELECT um.user_id, SUM(um.points) as total_points
  FROM user_matches um
  JOIN matches m ON m.id = um.match_id
  WHERE m.phase = 'group' AND m.has_played = true
  GROUP BY um.user_id
) sub
WHERE u.id = sub.user_id;

-- ─── 5. ASSIGN ROUND OF 32 TEAMS ────────────────────────────────────────────
-- Format: 1A vs 3C/D/E, 2A vs 2B, 1B vs 3A/D/E, etc. (FIFA format)
-- Qualified: Top 2 per group (24) + 8 best 3rd (CIV, GHA, IRN, NOR, BIH, SWE, COD, SCO)
-- Using typical FIFA R32 bracket structure

-- Match 1: 1A (MEX) vs 3C (SCO) - sorted by date
UPDATE matches SET local_team_id = 'MEX', visiting_team_id = 'SCO'
WHERE phase = 'round_of_32' AND match_date = '2026-06-28 19:00:00';

-- Match 2: 2C (MAR) vs 2D (TUR)
UPDATE matches SET local_team_id = 'MAR', visiting_team_id = 'TUR'
WHERE phase = 'round_of_32' AND match_date = '2026-06-29 17:00:00';

-- Match 3: 1B (SUI) vs 3A (CIV) -- using 3rd place from group E since CIV qualified
UPDATE matches SET local_team_id = 'SUI', visiting_team_id = 'CIV'
WHERE phase = 'round_of_32' AND match_date = '2026-06-29 20:30:00';

-- Match 4: 2A (KOR) vs 2B (CAN)
UPDATE matches SET local_team_id = 'KOR', visiting_team_id = 'CAN'
WHERE phase = 'round_of_32' AND match_date = '2026-06-30 01:00:00';

-- Match 5: 1C (BRA) vs 3F (SWE)
UPDATE matches SET local_team_id = 'BRA', visiting_team_id = 'SWE'
WHERE phase = 'round_of_32' AND match_date = '2026-06-30 17:00:00';

-- Match 6: 2E (ECU) vs 2F (JPN)
UPDATE matches SET local_team_id = 'ECU', visiting_team_id = 'JPN'
WHERE phase = 'round_of_32' AND match_date = '2026-06-30 21:00:00';

-- Match 7: 1D (USA) vs 3B (BIH)
UPDATE matches SET local_team_id = 'USA', visiting_team_id = 'BIH'
WHERE phase = 'round_of_32' AND match_date = '2026-07-01 01:00:00';

-- Match 8: 1E (GER) vs 3G (IRN)
UPDATE matches SET local_team_id = 'GER', visiting_team_id = 'IRN'
WHERE phase = 'round_of_32' AND match_date = '2026-07-01 16:00:00';

-- Match 9: 1F (NED) vs 3I (NOR)
UPDATE matches SET local_team_id = 'NED', visiting_team_id = 'NOR'
WHERE phase = 'round_of_32' AND match_date = '2026-07-01 20:00:00';

-- Match 10: 2G (EGY) vs 2H (URU)
UPDATE matches SET local_team_id = 'EGY', visiting_team_id = 'URU'
WHERE phase = 'round_of_32' AND match_date = '2026-07-02 00:00:00';

-- Match 11: 1G (BEL) vs 3L (GHA)
UPDATE matches SET local_team_id = 'BEL', visiting_team_id = 'GHA'
WHERE phase = 'round_of_32' AND match_date = '2026-07-02 19:00:00';

-- Match 12: 1H (ESP) vs 3K (COD)
UPDATE matches SET local_team_id = 'ESP', visiting_team_id = 'COD'
WHERE phase = 'round_of_32' AND match_date = '2026-07-02 23:00:00';

-- Match 13: 2I (SEN) vs 2J (AUT)
UPDATE matches SET local_team_id = 'SEN', visiting_team_id = 'AUT'
WHERE phase = 'round_of_32' AND match_date = '2026-07-03 03:00:00';

-- Match 14: 1I (FRA) vs 2K (COL)
UPDATE matches SET local_team_id = 'FRA', visiting_team_id = 'COL'
WHERE phase = 'round_of_32' AND match_date = '2026-07-03 18:00:00';

-- Match 15: 1J (ARG) vs 2L (CRO)
UPDATE matches SET local_team_id = 'ARG', visiting_team_id = 'CRO'
WHERE phase = 'round_of_32' AND match_date = '2026-07-03 22:00:00';

-- Match 16: 1K (POR) vs 1L (ENG)
UPDATE matches SET local_team_id = 'POR', visiting_team_id = 'ENG'
WHERE phase = 'round_of_32' AND match_date = '2026-07-04 01:30:00';

-- Clean up temp table
DROP TABLE IF EXISTS match_results;

COMMIT;
