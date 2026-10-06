-- Generated from ChapterAngularMomentum.lean — solution of BookProof.ChapterAngularMomentum.circHarm_differentiableAt
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum




open Complex

set_option maxHeartbeats 1000000 in
theorem solution {μ : ℕ} {z : ℂ} (hz : z ≠ 0) :
    DifferentiableAt ℝ (circHarm μ) z := by

  have hn : DifferentiableAt ℝ (fun w : ℂ => ‖w‖) z :=
    (contDiffAt_norm (n := 1) ℝ hz).differentiableAt (by norm_num)
  have hnorm : DifferentiableAt ℝ (fun w : ℂ => ((‖w‖ : ℝ) : ℂ)) z :=
    Complex.ofRealCLM.differentiableAt.comp z hn
  have hne : (fun w : ℂ => ((‖w‖ : ℝ) : ℂ)) z ≠ 0 := by
    simpa using (norm_ne_zero_iff.mpr hz)
  have hinv : DifferentiableAt ℝ (fun w : ℂ => (((‖w‖ : ℝ) : ℂ))⁻¹) z := hnorm.inv hne
  have hmul : DifferentiableAt ℝ (fun w : ℂ => w * (((‖w‖ : ℝ) : ℂ))⁻¹) z :=
    differentiableAt_id.mul hinv
  have hfun : circHarm μ = fun w : ℂ => (w * (((‖w‖ : ℝ) : ℂ))⁻¹) ^ μ := by
    funext w; rw [circHarm, div_eq_mul_inv]
  rw [hfun]
  exact hmul.pow μ
