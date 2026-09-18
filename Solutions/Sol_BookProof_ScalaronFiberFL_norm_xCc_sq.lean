-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.norm_xCc_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_xCc_eq_toLp
import Theorems.Thm_BookProof_ScalaronFiberFL_toLp_norm_sq
import Theorems.Thm_BookProof_ScalaronEsa_mulCc_apply
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) :
    ‖xCc (ccEquiv ℝ f)‖ ^ 2 = ∫ x, x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by

  rw [xCc_eq_toLp, toLp_norm_sq]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  change ‖(mulCc (fun x : ℝ => x) contDiff_id f) x‖ ^ 2 = x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2
  rw [mulCc_apply, norm_mul, mul_pow]
  simp [sq_abs]
