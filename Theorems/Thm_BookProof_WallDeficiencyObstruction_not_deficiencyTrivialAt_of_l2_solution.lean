-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.not_deficiencyTrivialAt_of_l2_solution
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterWeakSecondDerivative
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.not_deficiencyTrivialAt_of_l2_solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) {W : ℝ → ℂ}
    (hsol : IsL2Ode V z W) (hne : ∃ x, W x ≠ 0) :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z := by sorry
