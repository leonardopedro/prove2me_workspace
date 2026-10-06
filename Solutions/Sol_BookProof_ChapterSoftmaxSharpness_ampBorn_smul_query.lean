-- Generated from ChapterSoftmaxSharpness.lean — solution of BookProof.ChapterSoftmaxSharpness.ampBorn_smul_query
import Mathlib
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) (hc : c ≠ 0) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) :
    ampBorn (c • q) k j = ampBorn q k j := by

  have hinner : ∀ l, (inner ℝ (c • q) (k l) : ℝ) = c * inner ℝ q (k l) := fun l =>
    real_inner_smul_left _ _ _
  have hnum : (inner ℝ (c • q) (k j) : ℝ) ^ 2 = c ^ 2 * (inner ℝ q (k j)) ^ 2 := by
    rw [hinner]; ring
  have hden : ∑ l, (inner ℝ (c • q) (k l) : ℝ) ^ 2
      = c ^ 2 * ∑ l, (inner ℝ q (k l)) ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => by rw [hinner]; ring
  rw [ampBorn, ampBorn, hnum, hden, mul_div_mul_left _ _ (pow_ne_zero 2 hc)]
