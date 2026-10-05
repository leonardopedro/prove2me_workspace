-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.norm_scaleCLM_le
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {R : ℝ} (hR : 0 < R) : ‖scaleCLM d R‖ ≤ R⁻¹ := by

  refine (norm_smul_le (R⁻¹) (ContinuousLinearMap.id ℝ (Vd d))).trans ?_
  have h1 : ‖ContinuousLinearMap.id ℝ (Vd d)‖ ≤ 1 := ContinuousLinearMap.norm_id_le
  have h2 : ‖(R⁻¹ : ℝ)‖ = R⁻¹ := by
    rw [Real.norm_eq_abs, abs_of_pos (by positivity)]
  rw [h2]
  nlinarith [norm_nonneg (ContinuousLinearMap.id ℝ (Vd d)), inv_pos.mpr hR]
