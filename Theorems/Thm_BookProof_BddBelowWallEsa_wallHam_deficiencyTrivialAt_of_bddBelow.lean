-- Generated from ChapterBddBelowWallEsa.lean — theorem BookProof.BddBelowWallEsa.wallHam_deficiencyTrivialAt_of_bddBelow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv
open BookProof.WeakSecondDeriv.IsTestFun
open BookProof.BddBelowWallEsa



open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

theorem BookProof.BddBelowWallEsa.wallHam_deficiencyTrivialAt_of_bddBelow (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {K : ℝ} (hVK : ∀ x, -K ≤ V x)
    {z : ℂ} (hzre : z.re = 0) (hzim : z.im ≠ 0) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by sorry
