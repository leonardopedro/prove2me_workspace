-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.kinOpR_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.StrichartzWave
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.ScalaronWallEsa.kinOpR_apply (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    (kinOpR f) x = -deriv (deriv (f : ℝ → ℂ)) x := by sorry
