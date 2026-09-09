import Mathlib
import BookProof.ChapterDefinabilityFragment

/-!
# Countable definability

For a fixed countable language, expressions can be represented by a countable
syntax type.  Consequently, the range of any interpretation into the reals is
countable.  This is the precise set-theoretic content of “only countably many
reals are definable in a fixed countable language.”  The module does not claim
that non-definable reals can *only* be specified by intervals; instead it records
the valid interval-constraint statement separately.
-/

namespace BookProof.ChapterCountableDefinability

/-- Values denoted by a countable syntax form a countable subset of `ℝ`. -/
theorem definable_reals_countable {Syntax : Type*} [Countable Syntax]
    (denote : Syntax → ℝ) : (Set.range denote).Countable := by
  exact Set.countable_range denote

/-- There exists a real outside the values denoted by any countable syntax. -/
theorem exists_nondefinable_real {Syntax : Type*} [Countable Syntax]
    (denote : Syntax → ℝ) : ∃ x : ℝ, x ∉ Set.range denote := by
  by_contra h
  push_neg at h
  have : (Set.univ : Set ℝ).Countable := by
    convert definable_reals_countable denote
    ext x
    simp [h]
  exact Cardinal.not_countable_real this

/-- A finite-width interval constraint specifies all of its members rather than
selecting a unique real whenever its endpoints are distinct. -/
theorem interval_constraint_not_unique {a b : ℝ} (h : a < b) :
    ∃ x y : ℝ, x ≠ y ∧ x ∈ Set.Icc a b ∧ y ∈ Set.Icc a b := by
  exact ⟨a, b, ne_of_lt h, Set.left_mem_Icc.mpr (le_of_lt h), Set.right_mem_Icc.mpr (le_of_lt h)⟩

end BookProof.ChapterCountableDefinability
