-- Generated from ChapterScalaronWallEsa.lean — theorem BookProof.ScalaronWallEsa.wallHam_deficiencyTrivialAt
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.ScalaronEsa
open BookProof.WeakSecondDeriv
open BookProof.WeakSecondDeriv.IsTestFun
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.ScalaronWallEsa.wallHam_deficiencyTrivialAt (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (hVnn : ∀ x, 0 ≤ V x) {z : ℂ} (hz : z.re = 0) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by sorry
