-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.vonNeumann_abelian_class_countable
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_injective
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_diagOp_comm
import Theorems.Thm_BookProof_ChapterAbelianDiagonalCountable_commutes_diagOp_iff
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    Function.Injective diagOp ∧
      (∀ d e : EllInf, (diagOp d).comp (diagOp e) = (diagOp e).comp (diagOp d)) ∧
      (∀ T : Ell2C →L[ℂ] Ell2C,
        (∀ d : EllInf, T.comp (diagOp d) = (diagOp d).comp T) ↔ ∃ d : EllInf, T = diagOp d) := ⟨diagOp_injective, diagOp_comm, commutes_diagOp_iff⟩
