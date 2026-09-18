-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.integral_deriv_le_quadForm
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.integral_deriv_le_quadForm (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (f : ccSchwartz ℝ) :
    (∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2) ≤ quadForm (W.ham s) (ccEquiv ℝ f) := by sorry
