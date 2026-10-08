-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.starobinskyWall_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStarobinskyPotential
open BookProof.ScalaronEsa
open BookProof.Starobinsky
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.ScalaronWallEsa.starobinskyWall_esa {M alpha : ℝ} (halpha : 0 < alpha) :
    EssentiallySelfAdjointOn (ccDomain ℝ)
      (wallHam (fun phi : ℝ => starobinskyV M alpha phi) (contDiff_starobinskyV M alpha)) := by sorry
