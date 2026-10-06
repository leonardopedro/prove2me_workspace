-- Generated from ChapterGaugeUnconstrainedSpectrum.lean — solution of BookProof.ChapterGaugeUnconstrainedSpectrum.exists_isUnconstrainedGaugeFixing
import Mathlib
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Theorems.Thm_BookProof_ChapterGaugeUnconstrainedSpectrum_constrainedSpectrum_eq_univ_of_isUnconstrained
import Theorems.Thm_BookProof_ChapterGaugeUnconstrainedSpectrum_shift_isUnconstrainedGaugeFixing
open BookProof.ChapterGaugeUnconstrainedSpectrum




variable {X : Type*}

variable {X : Type*}
variable {G : Type*} [Group G]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (G : Type) (_ : Group G) (X : Type) (U : G → Op X),
      Nontrivial G ∧ IsUnconstrainedGaugeFixing U ∧
        constrainedSpectrum U = Set.univ := by

  refine ⟨Multiplicative ℤ, inferInstance, ℤ,
    fun m => permOp (shiftPerm m), inferInstance, shift_isUnconstrainedGaugeFixing, ?_⟩
  refine constrainedSpectrum_eq_univ_of_isUnconstrained
    shift_isUnconstrainedGaugeFixing ?_
  ext f k
  change f ((shiftPerm 1).symm k) = f k
  have h1 : shiftPerm 1 = (1 : Equiv.Perm ℤ) := by ext k; simp
  rw [h1]
  simp [Equiv.Perm.one_def]
