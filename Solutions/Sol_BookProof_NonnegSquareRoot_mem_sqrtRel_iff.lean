-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.mem_sqrtRel_iff
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
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
theorem solution {hT : IsNonnegSelfAdjoint T} {p : F × F} :
    p ∈ sqrtRel hT ↔ ∃ y, sqrtB hT y = p.1 ∧ sqrtC hT y = p.2 := by

  constructor
  · rintro ⟨y, hy⟩
    exact ⟨y, by simp [← hy], by simp [← hy]⟩
  · rintro ⟨y, h1, h2⟩
    exact ⟨y, Prod.ext h1 h2⟩
