-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.mem_domain_relOfCLM_iff
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Theorems.Thm_BookProof_ResolventCorrespondence_mem_relOfCLM_iff
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.UnboundedPolar BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution {x : F} :
    (∃ w, (x, w) ∈ relOfCLM R) ↔ x ∈ LinearMap.range (R : F →ₗ[ℂ] F) := by

  constructor
  · rintro ⟨w, hw⟩
    obtain ⟨y, hy1, -⟩ := mem_relOfCLM_iff.1 hw
    exact ⟨y, hy1⟩
  · rintro ⟨y, hy⟩
    exact ⟨y - R y, mem_relOfCLM_iff.2 ⟨y, hy, rfl⟩⟩
