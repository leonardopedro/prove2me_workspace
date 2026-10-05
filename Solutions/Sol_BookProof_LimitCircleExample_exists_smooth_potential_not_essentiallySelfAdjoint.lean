-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.exists_smooth_potential_not_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_contDiff_lcV
import Theorems.Thm_BookProof_LimitCircleExample_lcV_not_essentiallySelfAdjoint
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V),
      ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam V hV) := ⟨lcV, contDiff_lcV, lcV_not_essentiallySelfAdjoint⟩
