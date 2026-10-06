-- Generated from ChapterGaugeCasimirAverage.lean — solution of BookProof.ChapterGaugeCasimirAverage.casimir_apply_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterGaugeCasimirAverage
import Theorems.Thm_BookProof_ChapterGaugeCasimirAverage_casimir_apply
import Theorems.Thm_BookProof_ChapterGaugeCasimirAverage_inner_casimir
open BookProof.ChapterGaugeCasimirAverage




open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric)
    (v : V) : casimir T v = 0 ↔ ∀ a, T a v = 0 := by

  constructor
  · intro h
    have h0 : ((∑ a, ‖T a v‖ ^ 2 : ℝ) : ℂ) = 0 := by
      rw [← inner_casimir T hT v, h, inner_zero_right]
    have hr : (∑ a, ‖T a v‖ ^ 2 : ℝ) = 0 := by exact_mod_cast h0
    intro a
    have ha := (Finset.sum_eq_zero_iff_of_nonneg
      (fun b _ => sq_nonneg ‖T b v‖)).mp hr a (Finset.mem_univ a)
    simpa using ha
  · intro h
    rw [casimir_apply]
    simp [h]
