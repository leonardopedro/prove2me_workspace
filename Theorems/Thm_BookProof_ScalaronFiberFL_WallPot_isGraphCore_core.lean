-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.WallPot.isGraphCore_core
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
open BookProof.ScalaronFiberFL
open BookProof.ScalaronFiberFL.WallPot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (W : WallPot) (s : ℝ)
variable (W : WallPot) (s : ℝ) (hs : 0 ≤ s)



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

theorem BookProof.ScalaronFiberFL.WallPot.isGraphCore_core : IsGraphCore (W.comparison s hs) (ccDomain ℝ) := by sorry
