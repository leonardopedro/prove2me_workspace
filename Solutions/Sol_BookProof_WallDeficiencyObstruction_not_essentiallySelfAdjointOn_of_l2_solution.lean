-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.not_essentiallySelfAdjointOn_of_l2_solution
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_WallDeficiencyObstruction_not_deficiencyTrivialAt_of_l2_solution
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {W : ℝ → ℂ}
    (hsol : IsL2Ode V Complex.I W) (hne : ∃ x, W x ≠ 0) :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := by

  intro h
  exact not_deficiencyTrivialAt_of_l2_solution V hV Complex.I hsol hne h.1
