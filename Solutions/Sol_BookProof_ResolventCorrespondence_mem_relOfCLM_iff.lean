-- Generated from ChapterResolventCorrespondence.lean — solution of BookProof.ResolventCorrespondence.mem_relOfCLM_iff
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
open BookProof.ResolventCorrespondence




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution {p : F × F} :
    p ∈ relOfCLM R ↔ ∃ y, R y = p.1 ∧ y - R y = p.2 := by

  constructor
  · rintro ⟨y, hy⟩
    exact ⟨y, by simp [← hy], by simp [← hy]⟩
  · rintro ⟨y, h1, h2⟩
    exact ⟨y, Prod.ext h1 (by simpa using h2)⟩
