-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.adjPairs_relOfCLM
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_relOfCLM_le_adjPairs
import Theorems.Thm_BookProof_ResolventCorrespondence_exists_mem_relOfCLM_add
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hR : IsSelfAdjoint R) : adjPairs (relOfCLM R) = relOfCLM R :=
  adjPairs_eq_self_of_symmetric_of_surjective (relOfCLM_le_adjPairs hR)
      (exists_mem_relOfCLM_add R)
