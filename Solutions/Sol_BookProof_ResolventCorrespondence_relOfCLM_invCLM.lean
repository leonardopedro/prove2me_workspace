-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.relOfCLM_invCLM
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_isNonnegSelfAdjoint_relOfCLM
import Theorems.Thm_BookProof_ResolventCorrespondence_invCLM_relOfCLM
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_le_one
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_nonneg
import Theorems.Thm_BookProof_PositiveSquareRoot_rel_eq_of_invCLM_eq
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) : relOfCLM (invCLM hT) = T :=
  rel_eq_of_invCLM_eq
      (isNonnegSelfAdjoint_relOfCLM (invCLM_nonneg hT) (invCLM_le_one hT)) hT
      (invCLM_relOfCLM (invCLM_nonneg hT) (invCLM_le_one hT))
