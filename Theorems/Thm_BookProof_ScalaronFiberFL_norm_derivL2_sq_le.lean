-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.norm_derivL2_sq_le
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.norm_derivL2_sq_le (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    ‖derivL2 f‖ ^ 2 ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by sorry
