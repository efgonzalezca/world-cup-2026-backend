/**
 * Core scoring logic for the World Cup prediction game.
 * Extracted as a pure function for testability.
 *
 * Rules per match (max 7 points):
 *   - Correct result (W/D/L): 2 pts
 *   - Correct local goals:    1 pt
 *   - Correct visitor goals:  1 pt
 *   - Exact score bonus:      3 pts
 *   - Draw bonus:             1 pt  (non-exact draw only)
 */
export interface ScoringResult {
  resultPoints: number;
  localScorePoints: number;
  visitorScorePoints: number;
  exactScoreBonus: number;
  drawBonus: number;
  total: number;
}

export function calculatePoints(
  predLocal: number | null,
  predVisitor: number | null,
  realLocal: number,
  realVisitor: number,
): ScoringResult {
  if (predLocal === null || predVisitor === null) {
    return { resultPoints: 0, localScorePoints: 0, visitorScorePoints: 0, exactScoreBonus: 0, drawBonus: 0, total: 0 };
  }

  let resultPoints = 0;
  let localScorePoints = 0;
  let visitorScorePoints = 0;
  let exactScoreBonus = 0;
  let drawBonus = 0;

  // Result: compare sign of goal difference
  const predResult = Math.sign(predLocal - predVisitor);
  const realResult = Math.sign(realLocal - realVisitor);
  if (predResult === realResult) resultPoints = 2;

  // Individual goal matches
  if (predLocal === realLocal) localScorePoints = 1;
  if (predVisitor === realVisitor) visitorScorePoints = 1;

  // Exact score bonus
  const isExact = predLocal === realLocal && predVisitor === realVisitor;
  if (isExact) exactScoreBonus = 3;

  // Draw bonus: both predicted and real are draws, but NOT exact score
  const predIsDraw = predLocal === predVisitor;
  const realIsDraw = realLocal === realVisitor;
  if (predIsDraw && realIsDraw && !isExact) drawBonus = 1;

  const total = resultPoints + localScorePoints + visitorScorePoints + exactScoreBonus + drawBonus;

  return { resultPoints, localScorePoints, visitorScorePoints, exactScoreBonus, drawBonus, total };
}
