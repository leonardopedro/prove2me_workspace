-- Generated from ChapterGaugeCasimirAverage.lean — solution of BookProof.ChapterGaugeCasimirAverage.inner_casimir
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
import Theorems.Thm_BookProof_ChapterGaugeCasimirAverage_casimir_apply
open BookProof.ChapterGaugeCasimirAverage




open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric) (v : V) :
    ⟪v, casimir T v⟫_ℂ = ((∑ a, ‖T a v‖ ^ 2 : ℝ) : ℂ) := by

  rw [casimir_apply, inner_sum]
  push_cast
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← hT a v (T a v), inner_self_eq_norm_sq_to_K]
  norm_cast
