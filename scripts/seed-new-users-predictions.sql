-- =============================================================================
-- Predictions for 6 new users (carlos_10, maria_fut, juancho, laura_gol, pipe_crack, sebas_pro)
-- All played matches: group(72) + R32(16) + R16(8) + QF(4) + SF(2) = 102
-- =============================================================================

BEGIN;

CREATE TEMP TABLE mr AS
SELECT m.id as match_id, m.local_team_id as lt, m.visiting_team_id as vt,
       m.local_result as lr, m.visiting_result as vr, m.phase
FROM matches m WHERE m.has_played = true;

-- ═══════════════════════════════════════════════════════════════════════════════
-- carlos_10: Favors big teams, overestimates favorites
-- ═══════════════════════════════════════════════════════════════════════════════
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
      -- R32
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 3 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 2 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 4 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 1
      WHEN mr.lt='USA' AND mr.vt='BIH' THEN 3 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 4
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 3 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 2 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 4
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 0 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 3
      WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 3 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 1
      -- R16
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 0 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 3 WHEN mr.lt='USA' AND mr.vt='GER' THEN 0
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 2 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 0 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 2
      -- QF
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 2
      WHEN mr.lt='NED' AND mr.vt='ESP' THEN 1 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 1
      -- SF
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 0 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 1
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
      -- R32
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 0 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 0 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 2
      WHEN mr.lt='USA' AND mr.vt='BIH' THEN 0 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 0 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 3
      WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 1 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 0
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 2 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 2
      -- R16
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 1 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 2
      WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 0 WHEN mr.lt='USA' AND mr.vt='GER' THEN 2
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 1 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 3
      WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 4 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 0
      -- QF
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 2
      WHEN mr.lt='NED' AND mr.vt='ESP' THEN 2 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 3
      -- SF
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 3 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 2
      ELSE 0 END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'carlos_10'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- maria_fut: Conservative (low scores)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0 WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 0 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 0 WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 0
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 1 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 1 WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 0 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 0 WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 2
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 0 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 1 WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1 WHEN mr.lt='TUR' AND mr.vt='USA' THEN 0 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 1
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 3 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1 WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 2
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 0 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 0 WHEN mr.lt='NED' AND mr.vt='JPN' THEN 1 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 0 WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 0
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 1 WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 0
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 0 WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 2 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 0
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1 WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 0
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 0 WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 2 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 0 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 1 WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 2 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1 WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 1 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 0 WHEN mr.lt='POR' AND mr.vt='UZB' THEN 2 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 0 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1 WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 0 WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 0 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 1 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 0 WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 2 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 0 WHEN mr.lt='USA' AND mr.vt='BIH' THEN 1 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 1 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 0 WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 1 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 2
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 1 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 1 WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 0
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 0 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 1 WHEN mr.lt='USA' AND mr.vt='GER' THEN 0
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 1 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 0 WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 0 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 1
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 1 WHEN mr.lt='NED' AND mr.vt='ESP' THEN 0 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 0
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 0 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 1
      ELSE 1 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 0 WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 0 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 0
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 1 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1 WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 0 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 0 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 0 WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 0 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 1 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1 WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 0
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 1 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 0 WHEN mr.lt='USA' AND mr.vt='PAR' THEN 0 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 1
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 0 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1 WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 0
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 0 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 1 WHEN mr.lt='GER' AND mr.vt='CIV' THEN 0 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 0
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 1 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 2 WHEN mr.lt='NED' AND mr.vt='JPN' THEN 0 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1 WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 0 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 0 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0 WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 0 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 1 WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 0 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 0 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 0 WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 1
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 0 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1 WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 1 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 0 WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 0 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 0
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 0 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 0 WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 2
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 0 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1 WHEN mr.lt='POR' AND mr.vt='UZB' THEN 0 WHEN mr.lt='COL' AND mr.vt='COD' THEN 0
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 0 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 0 WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 0
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 0 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 1 WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 1 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 0
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 0 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 0 WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 0 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 0
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 0 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 1 WHEN mr.lt='USA' AND mr.vt='BIH' THEN 0 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 0
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 0 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 1 WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 0 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 0
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 0 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 0 WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 0 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 1
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 1 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 0 WHEN mr.lt='USA' AND mr.vt='GER' THEN 1
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 0 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 1 WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 2 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 0
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 0 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 1 WHEN mr.lt='NED' AND mr.vt='ESP' THEN 1 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 1
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 1 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 1
      ELSE 0 END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'maria_fut'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- juancho: Chaotic (high goals, many misses)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 3 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 2 WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 2 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 3
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 2 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 1 WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 2 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 1
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 3 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 4 WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 2 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 3
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 1 WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 5
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 1 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 4 WHEN mr.lt='USA' AND mr.vt='PAR' THEN 2 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 3 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 2 WHEN mr.lt='TUR' AND mr.vt='USA' THEN 1 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 6 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2 WHEN mr.lt='GER' AND mr.vt='CIV' THEN 3 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 4
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 2 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 1 WHEN mr.lt='NED' AND mr.vt='JPN' THEN 3 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 2
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 2 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 1 WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 3 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 1
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 3 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 2 WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 1
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 2 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 1 WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 4 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 1
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 3 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 2 WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 3 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 1 WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 4 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 2
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 1 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 3 WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 4 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 3
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 3 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 2 WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 1
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 3 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 1 WHEN mr.lt='POR' AND mr.vt='UZB' THEN 4 WHEN mr.lt='COL' AND mr.vt='COD' THEN 3
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 2 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 2 WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 2 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 3
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 3 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 1 WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 1 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 2
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 2 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 2 WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 2
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 3 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 2 WHEN mr.lt='USA' AND mr.vt='BIH' THEN 4 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 3
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 2 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 1 WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 3 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 3
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 2 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 2 WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 4 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 2
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 2 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 4 WHEN mr.lt='USA' AND mr.vt='GER' THEN 2
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 3 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 1 WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 1 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 3
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 3 WHEN mr.lt='NED' AND mr.vt='ESP' THEN 2 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 2
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 1 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 2
      ELSE 2 END as ls,
    CASE
      WHEN mr.lt='MEX' AND mr.vt='RSA' THEN 1 WHEN mr.lt='KOR' AND mr.vt='CZE' THEN 2 WHEN mr.lt='CZE' AND mr.vt='RSA' THEN 1 WHEN mr.lt='MEX' AND mr.vt='KOR' THEN 1
      WHEN mr.lt='CZE' AND mr.vt='MEX' THEN 3 WHEN mr.lt='RSA' AND mr.vt='KOR' THEN 3 WHEN mr.lt='CAN' AND mr.vt='BIH' THEN 1 WHEN mr.lt='QAT' AND mr.vt='SUI' THEN 3
      WHEN mr.lt='SUI' AND mr.vt='BIH' THEN 2 WHEN mr.lt='CAN' AND mr.vt='QAT' THEN 1 WHEN mr.lt='SUI' AND mr.vt='CAN' THEN 2 WHEN mr.lt='BIH' AND mr.vt='QAT' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='MAR' THEN 2 WHEN mr.lt='HAI' AND mr.vt='SCO' THEN 2 WHEN mr.lt='SCO' AND mr.vt='MAR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='HAI' THEN 1
      WHEN mr.lt='SCO' AND mr.vt='BRA' THEN 3 WHEN mr.lt='MAR' AND mr.vt='HAI' THEN 1 WHEN mr.lt='USA' AND mr.vt='PAR' THEN 1 WHEN mr.lt='AUS' AND mr.vt='TUR' THEN 2
      WHEN mr.lt='USA' AND mr.vt='AUS' THEN 1 WHEN mr.lt='TUR' AND mr.vt='PAR' THEN 1 WHEN mr.lt='TUR' AND mr.vt='USA' THEN 2 WHEN mr.lt='PAR' AND mr.vt='AUS' THEN 2
      WHEN mr.lt='GER' AND mr.vt='CUW' THEN 1 WHEN mr.lt='CIV' AND mr.vt='ECU' THEN 2 WHEN mr.lt='GER' AND mr.vt='CIV' THEN 1 WHEN mr.lt='ECU' AND mr.vt='CUW' THEN 1
      WHEN mr.lt='ECU' AND mr.vt='GER' THEN 3 WHEN mr.lt='CUW' AND mr.vt='CIV' THEN 3 WHEN mr.lt='NED' AND mr.vt='JPN' THEN 2 WHEN mr.lt='SWE' AND mr.vt='TUN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='JPN' THEN 3 WHEN mr.lt='JPN' AND mr.vt='SWE' THEN 1 WHEN mr.lt='TUN' AND mr.vt='NED' THEN 3
      WHEN mr.lt='BEL' AND mr.vt='EGY' THEN 1 WHEN mr.lt='IRN' AND mr.vt='NZL' THEN 0 WHEN mr.lt='BEL' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='EGY' THEN 2
      WHEN mr.lt='EGY' AND mr.vt='IRN' THEN 1 WHEN mr.lt='NZL' AND mr.vt='BEL' THEN 4 WHEN mr.lt='ESP' AND mr.vt='CPV' THEN 1 WHEN mr.lt='SAU' AND mr.vt='URU' THEN 3
      WHEN mr.lt='ESP' AND mr.vt='SAU' THEN 1 WHEN mr.lt='URU' AND mr.vt='CPV' THEN 1 WHEN mr.lt='CPV' AND mr.vt='SAU' THEN 2 WHEN mr.lt='URU' AND mr.vt='ESP' THEN 2
      WHEN mr.lt='FRA' AND mr.vt='SEN' THEN 1 WHEN mr.lt='IRQ' AND mr.vt='NOR' THEN 2 WHEN mr.lt='FRA' AND mr.vt='IRQ' THEN 1 WHEN mr.lt='NOR' AND mr.vt='SEN' THEN 1
      WHEN mr.lt='NOR' AND mr.vt='FRA' THEN 2 WHEN mr.lt='SEN' AND mr.vt='IRQ' THEN 1 WHEN mr.lt='ARG' AND mr.vt='ALG' THEN 1 WHEN mr.lt='AUT' AND mr.vt='JOR' THEN 1
      WHEN mr.lt='ARG' AND mr.vt='AUT' THEN 1 WHEN mr.lt='JOR' AND mr.vt='ALG' THEN 1 WHEN mr.lt='ALG' AND mr.vt='AUT' THEN 2 WHEN mr.lt='JOR' AND mr.vt='ARG' THEN 5
      WHEN mr.lt='POR' AND mr.vt='COD' THEN 1 WHEN mr.lt='UZB' AND mr.vt='COL' THEN 2 WHEN mr.lt='POR' AND mr.vt='UZB' THEN 1 WHEN mr.lt='COL' AND mr.vt='COD' THEN 1
      WHEN mr.lt='COL' AND mr.vt='POR' THEN 2 WHEN mr.lt='COD' AND mr.vt='UZB' THEN 1 WHEN mr.lt='ENG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='GHA' AND mr.vt='PAN' THEN 1
      WHEN mr.lt='ENG' AND mr.vt='GHA' THEN 1 WHEN mr.lt='PAN' AND mr.vt='CRO' THEN 2 WHEN mr.lt='PAN' AND mr.vt='ENG' THEN 3 WHEN mr.lt='CRO' AND mr.vt='GHA' THEN 1
      WHEN mr.lt='MEX' AND mr.vt='SCO' THEN 1 WHEN mr.lt='MAR' AND mr.vt='TUR' THEN 2 WHEN mr.lt='SUI' AND mr.vt='CIV' THEN 2 WHEN mr.lt='KOR' AND mr.vt='CAN' THEN 1
      WHEN mr.lt='BRA' AND mr.vt='SWE' THEN 1 WHEN mr.lt='ECU' AND mr.vt='JPN' THEN 3 WHEN mr.lt='USA' AND mr.vt='BIH' THEN 1 WHEN mr.lt='GER' AND mr.vt='IRN' THEN 1
      WHEN mr.lt='NED' AND mr.vt='NOR' THEN 1 WHEN mr.lt='EGY' AND mr.vt='URU' THEN 3 WHEN mr.lt='BEL' AND mr.vt='GHA' THEN 1 WHEN mr.lt='ESP' AND mr.vt='COD' THEN 1
      WHEN mr.lt='SEN' AND mr.vt='AUT' THEN 1 WHEN mr.lt='FRA' AND mr.vt='COL' THEN 2 WHEN mr.lt='ARG' AND mr.vt='CRO' THEN 1 WHEN mr.lt='POR' AND mr.vt='ENG' THEN 2
      WHEN mr.lt='MEX' AND mr.vt='MAR' THEN 3 WHEN mr.lt='CIV' AND mr.vt='KOR' THEN 2 WHEN mr.lt='BRA' AND mr.vt='JPN' THEN 2 WHEN mr.lt='USA' AND mr.vt='GER' THEN 3
      WHEN mr.lt='NED' AND mr.vt='URU' THEN 2 WHEN mr.lt='BEL' AND mr.vt='ESP' THEN 2 WHEN mr.lt='AUT' AND mr.vt='FRA' THEN 3 WHEN mr.lt='ARG' AND mr.vt='ENG' THEN 2
      WHEN mr.lt='MAR' AND mr.vt='KOR' THEN 1 WHEN mr.lt='BRA' AND mr.vt='GER' THEN 2 WHEN mr.lt='NED' AND mr.vt='ESP' THEN 3 WHEN mr.lt='FRA' AND mr.vt='ARG' THEN 3
      WHEN mr.lt='MAR' AND mr.vt='GER' THEN 3 WHEN mr.lt='ESP' AND mr.vt='ARG' THEN 3
      ELSE 1 END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'juancho'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- laura_gol: Good predictor (close to results)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    -- She predicts close to actual results with small deviations
    CASE WHEN mr.lr IS NOT NULL THEN GREATEST(0, mr.lr + (CASE WHEN random() < 0.3 THEN 1 WHEN random() < 0.2 THEN -1 ELSE 0 END)) ELSE 1 END as ls,
    CASE WHEN mr.vr IS NOT NULL THEN GREATEST(0, mr.vr + (CASE WHEN random() < 0.3 THEN 1 WHEN random() < 0.2 THEN -1 ELSE 0 END)) ELSE 0 END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'laura_gol'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- pipe_crack: Poor predictor (often wrong direction)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    -- Swaps teams frequently, wrong direction
    CASE WHEN random() < 0.4 THEN mr.vr ELSE GREATEST(0, mr.lr + (CASE WHEN random() < 0.5 THEN 1 ELSE -1 END)) END as ls,
    CASE WHEN random() < 0.4 THEN mr.lr ELSE GREATEST(0, mr.vr + (CASE WHEN random() < 0.5 THEN 1 ELSE -1 END)) END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'pipe_crack'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- sebas_pro: Expert (many exact or near-exact predictions)
-- ═══════════════════════════════════════════════════════════════════════════════
UPDATE user_matches um SET local_score = p.ls, visitor_score = p.vs
FROM (
  SELECT mr.match_id,
    -- Mostly gets it right, sometimes off by 1 on one side
    CASE WHEN random() < 0.45 THEN mr.lr WHEN random() < 0.7 THEN GREATEST(0, mr.lr + 1) ELSE GREATEST(0, mr.lr - 1) END as ls,
    CASE WHEN random() < 0.45 THEN mr.vr WHEN random() < 0.7 THEN GREATEST(0, mr.vr + 1) ELSE GREATEST(0, mr.vr - 1) END as vs
  FROM mr
) p
JOIN users u ON u.nickname = 'sebas_pro'
WHERE um.user_id = u.id AND um.match_id = p.match_id;

-- ═══════════════════════════════════════════════════════════════════════════════
-- RECALCULATE ALL POINTS
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

DROP TABLE IF EXISTS mr;

COMMIT;
