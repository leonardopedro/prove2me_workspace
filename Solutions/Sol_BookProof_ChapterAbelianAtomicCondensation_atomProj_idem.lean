-- Generated from ChapterAbelianAtomicCondensation.lean — solution of BookProof.ChapterAbelianAtomicCondensation.atomProj_idem
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_mul
open BookProof.ChapterAbelianAtomicCondensation



open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in
theorem solution (i : ℕ) : (atomProj i).comp (atomProj i) = atomProj i := by

  rw [atomProj, ← diagOp_mul]
  congr 1
  apply lp.ext
  funext j
  by_cases h : j = i
  · subst h; simp [coordUnit, lp.single_apply]
  · simp [coordUnit, lp.single_apply, h]
