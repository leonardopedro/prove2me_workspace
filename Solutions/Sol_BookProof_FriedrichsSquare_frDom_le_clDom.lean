-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.frDom_le_clDom
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_FriedrichsSquare_fst_mem_clDom_of_mem_factorRel
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) : frDom A ≤ clDom A := by

  intro x hx
  obtain ⟨z, hz⟩ := mem_frDom_iff.1 hx
  exact fst_mem_clDom_of_mem_factorRel (p := (x, z)) hz
