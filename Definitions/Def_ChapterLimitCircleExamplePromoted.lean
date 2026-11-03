-- Generated from ChapterLimitCircleExample.lean — the smoothness of the limit-circle
-- potential, which the platform's served ChapterLimitCircleExample copy predates
-- (§2.13 new-name route: submit-definition rejects an existing name, so the decl
-- lives here instead).  The three `lcV_not_*` statements cite it as the
-- `ContDiff` hypothesis of WallDeficiencyObstruction.
import Definitions.Def_ChapterLimitCircleExample
import Mathlib

namespace BookProof.LimitCircleExample

open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

/-- `V` is smooth: it is a rational function with nonvanishing denominator. -/
lemma contDiff_lcV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) lcV := by
  have hden : ∀ x : ℝ, (1 + x ^ 2) ^ 2 ≠ 0 := fun x => by positivity
  have h1 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞)
      fun x : ℝ => (2 * x ^ 2 - 4 * x) / (1 + x ^ 2) ^ 2 :=
    ContDiff.div (by fun_prop) (by fun_prop) hden
  have h2 : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) fun x : ℝ => (1 + x ^ 2) ^ 2 / 4 := by fun_prop
  exact h1.sub h2

end

end BookProof.LimitCircleExample
