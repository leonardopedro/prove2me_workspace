-- Generated from ChapterScalaronFiberFL.lean — solution of BookProof.ScalaronFiberFL.norm_derivL2_sq_le
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Theorems.Thm_BookProof_ScalaronFiberFL_integral_deriv_le_quadForm
import Theorems.Thm_BookProof_ScalaronFiberFL_norm_derivL2_sq
open BookProof.ScalaronFiberFL




open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    ‖derivL2 f‖ ^ 2 ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by

  rw [norm_derivL2_sq]
  exact integral_deriv_le_quadForm W s hs f
