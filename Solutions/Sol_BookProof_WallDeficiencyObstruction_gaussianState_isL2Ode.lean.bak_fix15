-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.gaussianState_isL2Ode
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsL2Ode harmonicShiftedV 0 gaussianState := by

  have hexp : ∀ x : ℝ, HasDerivAt (fun y : ℝ => Real.exp (-(y ^ 2 / 2)))
      (-x * Real.exp (-(x ^ 2 / 2))) x := by
    intro x
    have hp : HasDerivAt (fun y : ℝ => y ^ 2) (2 * x ^ (2 - 1)) x := hasDerivAt_pow 2 x
    have hd : HasDerivAt (fun y : ℝ => y ^ 2 / 2) ((2 * x ^ (2 - 1)) / 2) x := hp.div_const 2
    have hneg := hd.neg
    have h1 : HasDerivAt (fun y : ℝ => -(y ^ 2 / 2)) (-x) x := by
      have heq : -((2 * x ^ (2 - 1)) / 2) = -x := by rw [pow_one]; ring
      rw [heq] at hneg
      exact hneg
    have he := h1.exp
    rwa [show (fun y : ℝ => Real.exp (-(y ^ 2 / 2))) = (fun x => Real.exp (-(x ^ 2 / 2))) by rfl,
      show Real.exp (-(x ^ 2 / 2)) * -x = -x * Real.exp (-(x ^ 2 / 2)) by ring] at he
  refine ⟨fun x => ((-x * Real.exp (-(x ^ 2 / 2)) : ℝ) : ℂ), fun x => ?_, fun x => ?_, ?_⟩
  · exact (hexp x).ofReal_comp
  · have h3 : HasDerivAt (fun y : ℝ => (-y) * Real.exp (-(y ^ 2 / 2)))
        ((-1) * Real.exp (-(x ^ 2 / 2)) + (-x) * (-x * Real.exp (-(x ^ 2 / 2)))) x :=
      ((hasDerivAt_id x).neg).mul (hexp x)
    have hval : (-1 : ℝ) * Real.exp (-(x ^ 2 / 2)) + (-x) * (-x * Real.exp (-(x ^ 2 / 2)))
        = (x ^ 2 - 1) * Real.exp (-(x ^ 2 / 2)) := by ring
    rw [hval] at h3
    have h4 := h3.ofReal_comp
    have hcast : ((((x ^ 2 - 1) * Real.exp (-(x ^ 2 / 2)) : ℝ)) : ℂ)
        = (((harmonicShiftedV x : ℝ) : ℂ) - 0) * gaussianState x := by
      simp [harmonicShiftedV, gaussianState]
    rw [hcast] at h4
    exact h4
  · have hcont : Continuous gaussianState :=
      Complex.continuous_ofReal.comp (by fun_prop)
    refine (memLp_two_iff_integrable_sq_norm hcont.aestronglyMeasurable).2 ?_
    have h := integrable_exp_neg_mul_sq (b := (1 : ℝ)) one_pos
    refine h.congr ?_
    filter_upwards with x
    rw [gaussianState, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _),
      ← Real.exp_nat_mul]
    ring_nf
