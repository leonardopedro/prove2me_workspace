-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.norm_derivL2_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_toLp_norm_sq
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f : ccSchwartz ℝ) :
    ‖derivL2 f‖ ^ 2 = ∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 := by

  rw [derivL2, toLp_norm_sq]
  simp
