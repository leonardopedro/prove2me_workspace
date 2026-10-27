-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.ladderOrd_crePoly
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_coef_crePoly
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
theorem solution (i : Fin d) : LadderOrd (crePoly i) 1 := by

  intro m
  refine ⟨2 ^ m, by finiteness, fun p => ?_⟩
  unfold hn
  have hsupp : Function.support (fun b => wt m b * ‖coef b (pgLp (crePoly i p))‖ₑ ^ 2)
      ⊆ Set.range (fun a : Fin d →₀ ℕ => a + Finsupp.single i 1) := by
    intro b hb
    by_cases hbi : b i = 0
    · exfalso
      apply hb
      simp only
      rw [coef_crePoly, hbi]
      simp
    · refine ⟨b - Finsupp.single i 1, ?_⟩
      ext j
      by_cases hj : j = i
      · subst hj; simp; omega
      · simp [hj]
  rw [← (add_left_injective (Finsupp.single i 1)).tsum_eq hsupp, ← ENNReal.tsum_mul_left]
  refine ENNReal.tsum_le_tsum fun a => ?_
  rw [coef_crePoly, enorm_sqrt_mul_sq (by positivity), add_tsub_cancel_right, ← mul_assoc,
    ← mul_assoc]
  refine mul_le_mul_left ?_ _
  have hdeg : (a + Finsupp.single i 1).degree = a.degree + 1 := by
    rw [map_add, Finsupp.degree_single]
  have hai : a i ≤ a.degree := Finsupp.le_degree i a
  have hcast : ENNReal.ofReal (((a + Finsupp.single i 1 : Fin d →₀ ℕ) i : ℕ) : ℝ)
      = ((a i + 1 : ℕ) : ℝ≥0∞) := by
    rw [ENNReal.ofReal_natCast]
    simp
  rw [wt, wt, hdeg, hcast, show (2 : ℝ≥0∞) = ((2 : ℕ) : ℝ≥0∞) by norm_num]
  rw [← Nat.cast_pow, ← Nat.cast_pow, ← Nat.cast_pow, ← Nat.cast_mul, ← Nat.cast_mul,
    Nat.cast_le, pow_succ, ← mul_assoc, ← mul_pow]
  exact Nat.mul_le_mul (Nat.pow_le_pow_left (by omega) m) (by omega)
