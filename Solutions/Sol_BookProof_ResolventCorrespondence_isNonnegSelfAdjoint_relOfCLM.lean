-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.isNonnegSelfAdjoint_relOfCLM
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_isSelfAdjoint_of_nonneg
import Theorems.Thm_BookProof_ResolventCorrespondence_adjPairs_relOfCLM
import Theorems.Thm_BookProof_ResolventCorrespondence_relOfCLM_quadForm_nonneg
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
    IsNonnegSelfAdjoint (relOfCLM R) where
  adj :=
  where
    adj := adjPairs_relOfCLM (isSelfAdjoint_of_nonneg h0)
    nonneg := fun _ hp => relOfCLM_quadForm_nonneg h0 h1 hp
