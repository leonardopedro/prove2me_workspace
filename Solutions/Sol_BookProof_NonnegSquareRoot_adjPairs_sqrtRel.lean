-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.adjPairs_sqrtRel
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtRel_le_adjPairs
import Theorems.Thm_BookProof_NonnegSquareRoot_exists_mem_sqrtRel_add
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
theorem solution (hT : IsNonnegSelfAdjoint T) :
    adjPairs (sqrtRel hT) = sqrtRel hT :=
  adjPairs_eq_self_of_symmetric_of_surjective (sqrtRel_le_adjPairs hT)
      (exists_mem_sqrtRel_add hT)
