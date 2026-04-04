import { calculatePoints } from './scoring';

describe('calculatePoints (core scoring logic)', () => {
  describe('exact score — 7 points max', () => {
    it('should return 7 pts for exact match (2-1 pred, 2-1 real)', () => {
      const r = calculatePoints(2, 1, 2, 1);
      expect(r.resultPoints).toBe(2);
      expect(r.localScorePoints).toBe(1);
      expect(r.visitorScorePoints).toBe(1);
      expect(r.exactScoreBonus).toBe(3);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(7);
    });

    it('should return 7 pts for exact draw (0-0) — no draw bonus on exact', () => {
      const r = calculatePoints(0, 0, 0, 0);
      expect(r.exactScoreBonus).toBe(3);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(7);
    });

    it('should return 7 pts for exact draw (1-1) — no draw bonus on exact', () => {
      const r = calculatePoints(1, 1, 1, 1);
      expect(r.exactScoreBonus).toBe(3);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(7);
    });

    it('should return 7 pts for exact high score (5-3)', () => {
      const r = calculatePoints(5, 3, 5, 3);
      expect(r.total).toBe(7);
    });
  });

  describe('draw bonus — non-exact draw gives +1', () => {
    it('should return 3 pts for non-exact draw (0-0 pred, 1-1 real)', () => {
      const r = calculatePoints(0, 0, 1, 1);
      expect(r.resultPoints).toBe(2);
      expect(r.localScorePoints).toBe(0);
      expect(r.visitorScorePoints).toBe(0);
      expect(r.exactScoreBonus).toBe(0);
      expect(r.drawBonus).toBe(1);
      expect(r.total).toBe(3);
    });

    it('should return 3 pts for non-exact draw (2-2 pred, 3-3 real)', () => {
      const r = calculatePoints(2, 2, 3, 3);
      expect(r.resultPoints).toBe(2);
      expect(r.drawBonus).toBe(1);
      expect(r.total).toBe(3);
    });

    it('should return 3 pts for non-exact draw (1-1 pred, 0-0 real)', () => {
      const r = calculatePoints(1, 1, 0, 0);
      expect(r.resultPoints).toBe(2);
      expect(r.drawBonus).toBe(1);
      expect(r.total).toBe(3);
    });

    it('should return 3 pts for non-exact draw (3-3 pred, 1-1 real)', () => {
      const r = calculatePoints(3, 3, 1, 1);
      expect(r.resultPoints).toBe(2);
      expect(r.drawBonus).toBe(1);
      expect(r.total).toBe(3);
    });

    it('should NOT give draw bonus when prediction is not a draw (1-0 pred, 2-2 real)', () => {
      const r = calculatePoints(1, 0, 2, 2);
      expect(r.resultPoints).toBe(0);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(0);
    });

    it('should NOT give draw bonus when result is not a draw (1-1 pred, 2-0 real)', () => {
      const r = calculatePoints(1, 1, 2, 0);
      expect(r.resultPoints).toBe(0);
      expect(r.drawBonus).toBe(0);
    });

    it('should NOT give draw bonus on exact draw (2-2 pred, 2-2 real) — exact bonus applies instead', () => {
      const r = calculatePoints(2, 2, 2, 2);
      expect(r.exactScoreBonus).toBe(3);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(7);
    });
  });

  describe('correct result only — 2 points (non-draw)', () => {
    it('should return 2 pts for correct winner but wrong score (2-0 pred, 3-1 real)', () => {
      const r = calculatePoints(2, 0, 3, 1);
      expect(r.resultPoints).toBe(2);
      expect(r.localScorePoints).toBe(0);
      expect(r.visitorScorePoints).toBe(0);
      expect(r.exactScoreBonus).toBe(0);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(2);
    });

    it('should return 2 pts for correct visitor win (0-2 pred, 1-3 real)', () => {
      const r = calculatePoints(0, 2, 1, 3);
      expect(r.resultPoints).toBe(2);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(2);
    });
  });

  describe('partial matches — mixed points', () => {
    it('should return 3 pts for correct result + local goals (2-1 pred, 2-0 real)', () => {
      const r = calculatePoints(2, 1, 2, 0);
      expect(r.resultPoints).toBe(2);
      expect(r.localScorePoints).toBe(1);
      expect(r.visitorScorePoints).toBe(0);
      expect(r.exactScoreBonus).toBe(0);
      expect(r.drawBonus).toBe(0);
      expect(r.total).toBe(3);
    });

    it('should return 3 pts for correct result + visitor goals (1-2 pred, 0-2 real)', () => {
      const r = calculatePoints(1, 2, 0, 2);
      expect(r.resultPoints).toBe(2);
      expect(r.localScorePoints).toBe(0);
      expect(r.visitorScorePoints).toBe(1);
      expect(r.total).toBe(3);
    });

    it('should return 7 pts for exact score (1-0 pred, 1-0 real)', () => {
      const r = calculatePoints(1, 0, 1, 0);
      expect(r.total).toBe(7);
    });

    it('should return 1 pt for only local goals match, wrong result (2-1 pred, 2-3 real)', () => {
      const r = calculatePoints(2, 1, 2, 3);
      expect(r.resultPoints).toBe(0);
      expect(r.localScorePoints).toBe(1);
      expect(r.visitorScorePoints).toBe(0);
      expect(r.total).toBe(1);
    });

    it('should return 1 pt for only visitor goals match, wrong result (3-1 pred, 0-1 real)', () => {
      const r = calculatePoints(3, 1, 0, 1);
      expect(r.resultPoints).toBe(0);
      expect(r.localScorePoints).toBe(0);
      expect(r.visitorScorePoints).toBe(1);
      expect(r.total).toBe(1);
    });
  });

  describe('zero points', () => {
    it('should return 0 pts for completely wrong prediction (1-0 pred, 0-2 real)', () => {
      const r = calculatePoints(1, 0, 0, 2);
      expect(r.total).toBe(0);
    });

    it('should return 0 pts for wrong result direction (3-0 pred, 0-1 real)', () => {
      const r = calculatePoints(3, 0, 0, 1);
      expect(r.total).toBe(0);
    });
  });

  describe('null predictions', () => {
    it('should return 0 pts when local prediction is null', () => {
      const r = calculatePoints(null, 1, 2, 1);
      expect(r.total).toBe(0);
      expect(r.drawBonus).toBe(0);
    });

    it('should return 0 pts when visitor prediction is null', () => {
      const r = calculatePoints(2, null, 2, 1);
      expect(r.total).toBe(0);
    });

    it('should return 0 pts when both predictions are null', () => {
      const r = calculatePoints(null, null, 2, 1);
      expect(r.total).toBe(0);
    });
  });

  describe('edge cases', () => {
    it('should handle large scores (10-9 pred, 10-9 real)', () => {
      const r = calculatePoints(10, 9, 10, 9);
      expect(r.total).toBe(7);
    });

    it('should give 7 pts for exact score (1-2 pred, 1-2 real)', () => {
      const r = calculatePoints(1, 2, 1, 2);
      expect(r.total).toBe(7);
    });

    it('should give draw bonus for high-scoring non-exact draw (5-5 pred, 0-0 real)', () => {
      const r = calculatePoints(5, 5, 0, 0);
      expect(r.resultPoints).toBe(2);
      expect(r.drawBonus).toBe(1);
      expect(r.total).toBe(3);
    });
  });
});
