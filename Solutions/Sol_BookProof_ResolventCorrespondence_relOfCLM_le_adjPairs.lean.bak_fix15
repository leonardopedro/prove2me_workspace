-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.relOfCLM_le_adjPairs
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
theorem solution (hR : IsSelfAdjoint R) : relOfCLM R ≤ adjPairs (relOfCLM R) := by

  intro p hp q hq
  obtain ⟨y, hy1, hy2⟩ := mem_relOfCLM_iff.1 hp
  obtain ⟨z, hz1, hz2⟩ := mem_relOfCLM_iff.1 hq
  rw [← hy1, ← hy2, ← hz1, ← hz2, inner_sub_left, inner_sub_right,
    ← inner_isSelfAdjoint_left hR z y]
