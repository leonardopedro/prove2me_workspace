-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.toLp_norm_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_WallEsaSemibounded_inner_toLp_self
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (g : 𝓢(ℝ, ℂ)) :
    ‖g.toLp 2 (volume : Measure ℝ)‖ ^ 2 = ∫ x, ‖g x‖ ^ 2 := by

  have h := inner_toLp_self g
  rw [← inner_self_eq_norm_sq (𝕜 := ℂ) (g.toLp 2 (volume : Measure ℝ)), h]
  simp
