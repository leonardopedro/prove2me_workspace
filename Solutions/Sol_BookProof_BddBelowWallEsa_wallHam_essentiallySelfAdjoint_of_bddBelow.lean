-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.wallHam_essentiallySelfAdjoint_of_bddBelow
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_wallHam_deficiencyTrivialAt_of_bddBelow
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

variable {V : ℝ → ℝ} {z : ℂ} {W W' : ℝ → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {K : ℝ} (hVK : ∀ x, -K ≤ V x) :
    EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) :=
  ⟨wallHam_deficiencyTrivialAt_of_bddBelow V hV hVK (by simp) (by simp),
      wallHam_deficiencyTrivialAt_of_bddBelow V hV hVK (by simp) (by simp)⟩
