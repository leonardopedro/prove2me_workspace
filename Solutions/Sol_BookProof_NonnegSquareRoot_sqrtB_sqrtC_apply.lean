-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.sqrtB_sqrtC_apply
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_mul_sqrtC
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtC_mul_sqrtB
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
theorem solution (hT : IsNonnegSelfAdjoint T) (y : F) :
    sqrtB hT (sqrtC hT y) = sqrtC hT (sqrtB hT y) := by

  have h1 : (sqrtB hT * sqrtC hT) y = midOp (invCLM hT) y := by rw [sqrtB_mul_sqrtC]
  have h2 : (sqrtC hT * sqrtB hT) y = midOp (invCLM hT) y := by rw [sqrtC_mul_sqrtB]
  exact h1.trans h2.symm
