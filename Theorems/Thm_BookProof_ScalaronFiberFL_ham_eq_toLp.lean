-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.ham_eq_toLp
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

theorem BookProof.ScalaronFiberFL.ham_eq_toLp (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    W.ham s (ccEquiv ℝ f) = (hamS W s f).toLp 2 (volume : Measure ℝ) := by sorry
