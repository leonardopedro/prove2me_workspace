-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.clGraph_le_adjGraph
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_ClosureUniqueness_mem_adjGraph_iff
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : D →ₗ[ℂ] F} (hsym : SymmetricOn D A) :
    clGraph A ≤ adjGraph A := by

  intro p hp
  rw [mem_adjGraph_iff]
  intro v
  have h := clGraph_inner hsym hp v
  have h' := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h'
  exact h'.symm
