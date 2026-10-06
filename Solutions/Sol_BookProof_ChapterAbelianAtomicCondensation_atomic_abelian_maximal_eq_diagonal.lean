-- Generated from ChapterAbelianAtomicCondensation.lean — solution of BookProof.ChapterAbelianAtomicCondensation.atomic_abelian_maximal_eq_diagonal
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Theorems.Thm_BookProof_ChapterAbelianAtomicCondensation_atomic_abelian_subset_diagonal
open BookProof.ChapterAbelianAtomicCondensation



open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in
theorem solution {A : Set (Ell2C →L[ℂ] Ell2C)}
    (hA : IsAtomicAbelian A)
    (hmax : ∀ T : Ell2C →L[ℂ] Ell2C, (∀ S ∈ A, T.comp S = S.comp T) → T ∈ A) :
    A = Set.range diagOp := by

  refine Set.Subset.antisymm (atomic_abelian_subset_diagonal hA) ?_
  rintro T ⟨d, rfl⟩
  refine hmax _ fun S hS => ?_
  obtain ⟨e, rfl⟩ := atomic_abelian_subset_diagonal hA hS
  exact diagOp_comm d e
