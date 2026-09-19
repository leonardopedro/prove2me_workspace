-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.cc_integrable_sq
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

theorem BookProof.ScalaronFiberFL.cc_integrable_sq (f : ccSchwartz ℝ) :
    Integrable fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by sorry
