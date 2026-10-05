-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.deficiencyTrivialAt_conj_iff
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_WallDeficiencyObstruction_deficiencyTrivialAt_iff_no_l2_solution
import Theorems.Thm_BookProof_WallDeficiencyObstruction_isL2Ode_conj
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (z : ℂ) :
    DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) z
      ↔ DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) ((starRingEnd ℂ) z) := by

  have key : ∀ w : ℂ, DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) w →
      DeficiencyTrivialAt (ccDomain ℝ) (wallHam V hV) ((starRingEnd ℂ) w) := by
    intro w hw
    rw [deficiencyTrivialAt_iff_no_l2_solution] at hw ⊢
    intro W hsol x
    have hconj := isL2Ode_conj hsol
    rw [Complex.conj_conj] at hconj
    have := hw _ hconj x
    simpa using congrArg (starRingEnd ℂ) this
  refine ⟨key z, fun h => ?_⟩
  simpa using key _ h
