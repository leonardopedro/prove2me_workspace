-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.toLp_norm_sq
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.toLp_norm_sq (g : 𝓢(ℝ, ℂ)) :
    ‖g.toLp 2 (volume : Measure ℝ)‖ ^ 2 = ∫ x, ‖g x‖ ^ 2 := by sorry
