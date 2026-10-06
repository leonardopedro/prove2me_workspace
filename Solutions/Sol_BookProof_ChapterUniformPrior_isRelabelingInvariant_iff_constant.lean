-- Generated from ChapterUniformPrior.lean — solution of BookProof.ChapterUniformPrior.isRelabelingInvariant_iff_constant
import Mathlib
import Definitions.Def_ChapterUniformPrior
import Theorems.Thm_BookProof_ChapterUniformPrior_eq_of_isRelabelingInvariant
open BookProof.ChapterUniformPrior



open scoped BigOperators


variable {Hyp Data : Type*}

variable {Hyp Data : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (p : Hyp → ℝ) :
    IsRelabelingInvariant p ↔ ∃ c : ℝ, p = fun _ => c := by

  constructor
  · intro hp
    cases isEmpty_or_nonempty Hyp with
    | inl hempty =>
        exact ⟨0, funext fun x => isEmptyElim x⟩
    | inr hnonempty =>
        let a : Hyp := Classical.choice hnonempty
        exact ⟨p a, funext fun x => eq_of_isRelabelingInvariant p hp x a⟩
  · rintro ⟨c, rfl⟩
    exact fun _ => rfl
