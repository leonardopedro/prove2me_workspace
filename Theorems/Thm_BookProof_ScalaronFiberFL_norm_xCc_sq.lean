-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.norm_xCc_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.norm_xCc_sq (f : ccSchwartz ℝ) :
    ‖xCc (ccEquiv ℝ f)‖ ^ 2 = ∫ x, x ^ 2 * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by sorry
