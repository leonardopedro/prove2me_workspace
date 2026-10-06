-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.invCLM_relOfCLM
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_mem_relOfCLM
import Theorems.Thm_BookProof_ResolventCorrespondence_isNonnegSelfAdjoint_relOfCLM
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (h0 : 0 ≤ R) (h1 : R ≤ 1) :
    invCLM (isNonnegSelfAdjoint_relOfCLM h0 h1) = R := by

  ext h
  exact invCLM_eq_of_mem _ (mem_relOfCLM R h)
