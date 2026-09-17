-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.xCc_eq_toLp
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

theorem BookProof.ScalaronFiberFL.xCc_eq_toLp (f : ccSchwartz ℝ) :
    xCc (ccEquiv ℝ f) = (mulCc (fun x : ℝ => x) contDiff_id f).toLp 2 (volume : Measure ℝ) := by sorry
