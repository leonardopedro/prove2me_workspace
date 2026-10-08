-- Generated from ChapterScalaronFiberFL.lean — theorem BookProof.ScalaronFiberFL.hamS_apply
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallEsaSemibounded
import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterSchrodingerCutoffEsa
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.ScalaronFiberFL



open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded BookProof.WallEsaBddBelow
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable (W : WallPot) (s : ℝ)

theorem BookProof.ScalaronFiberFL.hamS_apply (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) (x : ℝ) :
    hamS W s f x
      = -deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) x + (W.pot s x : ℂ) * (f : 𝓢(ℝ, ℂ)) x := by sorry
