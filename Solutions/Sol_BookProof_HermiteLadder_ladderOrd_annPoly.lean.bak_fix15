-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.ladderOrd_annPoly
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_coef_annPoly
import Theorems.Thm_BookProof_HermiteLadder_enorm_sqrt_mul_sq
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) : LadderOrd (annPoly i) 1 := by

  intro m
  refine ⟨1, ENNReal.one_ne_top, fun p => ?_⟩
  rw [one_mul]
  unfold hn
  calc ∑' b, wt m b * ‖coef b (pgLp (annPoly i p))‖ₑ ^ 2
      ≤ ∑' b, wt (m + 1) (b + Finsupp.single i 1)
          * ‖coef (b + Finsupp.single i 1) (pgLp p)‖ₑ ^ 2 := by
        refine ENNReal.tsum_le_tsum fun b => ?_
        rw [coef_annPoly, enorm_sqrt_mul_sq (by positivity), ← mul_assoc]
        gcongr
        have hdeg : (b + Finsupp.single i 1).degree = b.degree + 1 := by
          rw [map_add, Finsupp.degree_single]
        have hbi : b i ≤ b.degree := Finsupp.le_degree i b
        rw [wt, wt, hdeg, show ENNReal.ofReal ((b i : ℝ) + 1) = ((b i + 1 : ℕ) : ℝ≥0∞) by
          rw [show ((b i : ℝ) + 1) = ((b i + 1 : ℕ) : ℝ) by push_cast; ring,
            ENNReal.ofReal_natCast]]
        rw [← Nat.cast_pow, ← Nat.cast_pow, ← Nat.cast_mul, Nat.cast_le, pow_succ]
        exact Nat.mul_le_mul (Nat.pow_le_pow_left (by omega) m) (by omega)
    _ ≤ ∑' a, wt (m + 1) a * ‖coef a (pgLp p)‖ₑ ^ 2 :=
        ENNReal.tsum_comp_le_tsum_of_injective (add_left_injective _)
          (fun a => wt (m + 1) a * ‖coef a (pgLp p)‖ₑ ^ 2)
