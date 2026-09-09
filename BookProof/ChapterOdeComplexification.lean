import Mathlib

/-!
# Complex ODE: z' = z² — Singularity has Measure Zero

For the complex ODE ż = z², solutions are z(t) = z₀ / (1 - t·z₀).
A singular time occurs when the denominator vanishes: t = 1/z₀.
We prove that the set of z₀ ∈ ℂ for which 1/z₀ is real has measure zero.
-/

open Complex
open MeasureTheory
open Set

/-- The blow-up time is t = 1/z₀. Its imaginary part is zero iff z₀ is real. -/
theorem singular_time_real_iff_im_zero (z0 : ℂ) (hz0 : z0 ≠ 0) :
    (1 / z0).im = 0 ↔ z0.im = 0 := by
  constructor
  · intro h
    have h_inv_im : (z0⁻¹).im = 0 := by
      simpa [div_eq_inv_mul] using h
    have h_norm_sq_ne_zero : Complex.normSq z0 ≠ 0 :=
      mt Complex.normSq_eq_zero.mp hz0
    rw [Complex.inv_im] at h_inv_im
    field_simp [h_norm_sq_ne_zero] at h_inv_im
    linarith
  · intro h
    rcases eq_or_ne z0 0 with (rfl | hz0')
    · exfalso; exact hz0 rfl
    · have h_real : z0 = (z0.re : ℂ) := by
        apply Complex.ext <;> simp [h]
      rw [h_real]
      simp

/-- The real axis has measure zero in ℝ² ≃ ℂ (Lebesgue measure).

The real axis is the proper subspace `{z | z.im = 0}` of ℂ ≃ ℝ².
Any proper subspace of a finite-dimensional real vector space has
Lebesgue measure zero (by `MeasureTheory.Measure.addHaar_submodule`). -/
theorem real_axis_volume_zero : volume {z : ℂ | z.im = 0} = 0 := by
  -- The set {z | z.im = 0} is the kernel of the linear functional im : ℂ → ℝ
  -- This is a proper subspace of ℂ (it doesn't contain i)
  -- By `addHaar_submodule`, any proper subspace has Haar measure zero
  let s : Submodule ℝ ℂ :=
    { carrier := {z | z.im = 0}
      add_mem' := by
        intro a b ha hb
        dsimp at ha hb
        dsimp
        rw [ha, hb]
        simp
      zero_mem' := by simp
      smul_mem' := by
        intro r z hz
        dsimp at hz
        dsimp
        rw [hz]
        simp
    }
  have hs_proper : s ≠ ⊤ := by
    intro h_eq
    have : (I : ℂ) ∈ s := by
      rw [h_eq]
      exact Submodule.mem_top
    simp [s] at this
  -- Use the lemma: any proper subspace has measure zero
  rw [show ({z : ℂ | z.im = 0} : Set ℂ) = (s : Set ℂ) by rfl]
  exact MeasureTheory.Measure.addHaar_submodule (volume : Measure ℂ) s hs_proper

/-- HEADLINE: Almost every initial condition has a non-real singular time.
    The set of z₀ ∈ ℂ for which the blow-up time is real has measure zero.

    Equivalently: for almost every z₀ ∈ ℂ, the ODE ż = z² with z(0) = z₀
    has a blow-up time t = 1/z₀ that is NOT a real number. -/
theorem ae_no_real_singular_time : ∀ᵐ z0 ∂(volume : Measure ℂ), (1 / z0).im ≠ 0 := by
  have h_set : {z : ℂ | (1 / z).im = 0} = {z : ℂ | z.im = 0} := by
    ext z
    by_cases hz0 : z = 0
    · subst hz0; simp
    · constructor
      · intro h; exact (singular_time_real_iff_im_zero z hz0).mp h
      · intro h; exact (singular_time_real_iff_im_zero z hz0).mpr h
  rw [ae_iff]
  have : {z0 | ¬((1 / z0).im ≠ 0)} = {z : ℂ | (1 / z).im = 0} := by
    ext z; simp only [Set.mem_setOf_eq, not_ne_iff]
  rw [this, h_set]
  exact real_axis_volume_zero
