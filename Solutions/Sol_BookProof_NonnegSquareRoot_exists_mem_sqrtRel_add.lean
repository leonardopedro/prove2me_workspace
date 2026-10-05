-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.exists_mem_sqrtRel_add
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_le_one
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_nonneg
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (h : F) :
    ∃ p ∈ sqrtRel hT, p.1 + p.2 = h := by

  obtain ⟨y, hy⟩ :=
    exists_sqrtOp_add_coSqrtOp_eq (invCLM_nonneg hT) (invCLM_le_one hT) h
  exact ⟨(sqrtB hT y, sqrtC hT y), mem_sqrtRel hT y, hy⟩
