-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.contDiff_lcV
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) lcV := by

  have hden : ∀ x : ℝ, (1 + x ^ 2) ^ 2 ≠ 0 := fun x => by positivity
  have h1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      fun x : ℝ => (2 * x ^ 2 - 4 * x) / (1 + x ^ 2) ^ 2 :=
    ContDiff.div (by fun_prop) (by fun_prop) hden
  have h2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => (1 + x ^ 2) ^ 2 / 4 := by fun_prop
  exact h1.sub h2
