-- Generated from ChapterNonnegSemigroupGenerator.lean — solution of BookProof.NonnegSemigroupGenerator.norm_expNeg_le_exp
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
open BookProof.NonnegSemigroupGenerator




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F) {mu : ℝ}
    (hmu : ∀ x : F, mu * ‖x‖ ^ 2 ≤ (inner ℂ (A x) x : ℂ).re) {t : ℝ} (ht : 0 ≤ t) (x : F) :
    ‖expNeg A t x‖ ≤ Real.exp (-(mu * t)) * ‖x‖ := by

  have hderiv : ∀ s : ℝ, HasDerivAt (fun s : ℝ => Real.exp (2 * mu * s) * ‖expNeg A s x‖ ^ 2)
      (Real.exp (2 * mu * s) * (2 * mu) * ‖expNeg A s x‖ ^ 2
        + Real.exp (2 * mu * s)
          * (-2 * (inner ℂ (A (expNeg A s x)) (expNeg A s x) : ℂ).re)) s := by
    intro s
    have hE : HasDerivAt (fun s : ℝ => Real.exp (2 * mu * s))
        (Real.exp (2 * mu * s) * (2 * mu)) s := by
      have h1 : HasDerivAt (fun y : ℝ => 2 * mu * y) (2 * mu) s := by
        simpa using (hasDerivAt_id s).const_mul (2 * mu)
      exact h1.exp
    exact hE.mul (hasDerivAt_normSq_expNeg A x s)
  have hanti : Antitone (fun s : ℝ => Real.exp (2 * mu * s) * ‖expNeg A s x‖ ^ 2) := by
    refine antitone_of_deriv_nonpos (fun s => (hderiv s).differentiableAt) (fun s => ?_)
    rw [(hderiv s).deriv]
    have h1 := hmu (expNeg A s x)
    have h2 : (0 : ℝ) < Real.exp (2 * mu * s) := Real.exp_pos _
    nlinarith
  have hkey := hanti ht
  simp only [mul_zero, Real.exp_zero, one_mul, expNeg_zero,
    ContinuousLinearMap.one_apply] at hkey
  have hsq : ‖expNeg A t x‖ ^ 2 ≤ (Real.exp (-(mu * t)) * ‖x‖) ^ 2 := by
    have hpos : (0 : ℝ) < Real.exp (2 * mu * t) := Real.exp_pos _
    have hmul : ‖expNeg A t x‖ ^ 2 ≤ Real.exp (-(2 * mu * t)) * ‖x‖ ^ 2 := by
      rw [Real.exp_neg, inv_mul_eq_div, le_div_iff₀ hpos]
      linarith [hkey]
    have hrw : Real.exp (-(2 * mu * t)) * ‖x‖ ^ 2 = (Real.exp (-(mu * t)) * ‖x‖) ^ 2 := by
      rw [mul_pow, ← Real.exp_nat_mul]
      ring_nf
    linarith [hmul, hrw.le, hrw.ge]
  have h1 : (0 : ℝ) ≤ ‖expNeg A t x‖ := norm_nonneg _
  have h2 : (0 : ℝ) ≤ Real.exp (-(mu * t)) * ‖x‖ := by positivity
  nlinarith [hsq, h1, h2]
