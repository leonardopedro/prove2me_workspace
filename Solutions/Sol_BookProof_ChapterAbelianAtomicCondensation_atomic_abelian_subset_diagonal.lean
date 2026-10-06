-- Generated from ChapterAbelianAtomicCondensation.lean — solution of BookProof.ChapterAbelianAtomicCondensation.atomic_abelian_subset_diagonal
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Theorems.Thm_BookProof_ChapterAbelianAtomicCondensation_commutes_atomProj_iff
open BookProof.ChapterAbelianAtomicCondensation



open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in
theorem solution {A : Set (Ell2C →L[ℂ] Ell2C)}
    (hA : IsAtomicAbelian A) : A ⊆ Set.range diagOp := by

  intro T hT
  obtain ⟨d, hd⟩ := (commutes_atomProj_iff T).1
    (fun i => hA.abelian T hT (atomProj i) (hA.atoms_mem i))
  exact ⟨d, hd.symm⟩
