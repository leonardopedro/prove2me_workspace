-- Generated from ChapterWallDeficiencyObstruction.lean — theorem BookProof.WallDeficiencyObstruction.not_essentiallySelfAdjointOn_of_l2_solution
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
open BookProof.WallDeficiencyObstruction



open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

theorem BookProof.WallDeficiencyObstruction.not_essentiallySelfAdjointOn_of_l2_solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {W : ℝ → ℂ}
    (hsol : IsL2Ode V Complex.I W) (hne : ∃ x, W x ≠ 0) :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by sorry
