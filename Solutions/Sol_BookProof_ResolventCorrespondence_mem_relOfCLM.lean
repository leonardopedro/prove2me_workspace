-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.mem_relOfCLM
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_mem_relOfCLM_iff
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) (y : F) : (R y, y - R y) ∈ relOfCLM R := mem_relOfCLM_iff.2 ⟨y, rfl, rfl⟩
