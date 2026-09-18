-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.norm_sq_le_quadForm
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.norm_sq_le_quadForm (W : WallPot) (s : ℝ) (hs : 1 ≤ s) (f : ccSchwartz ℝ) :
    ‖((ccEquiv ℝ f : ccDomain ℝ) : L2R)‖ ^ 2 ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by sorry
