-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.inner_invCLM_left
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_symm_inner
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (h k : F) :
    (inner ℂ (invCLM hT h) k : ℂ) = inner ℂ h (invCLM hT k) := by

  have h1 : (invCLM hT h, h - invCLM hT h) ∈ T := invCLM_mem hT h
  have h2 : (invCLM hT k, k - invCLM hT k) ∈ T := invCLM_mem hT k
  have hs : (inner ℂ (k - invCLM hT k) (invCLM hT h) : ℂ)
      = inner ℂ (invCLM hT k) (h - invCLM hT h) := symm_inner hT h1 h2
  have e3 : (inner ℂ (invCLM hT h) (k - invCLM hT k) : ℂ)
      = inner ℂ (h - invCLM hT h) (invCLM hT k) := by
    have := congrArg (starRingEnd ℂ) hs
    rwa [inner_conj_symm, inner_conj_symm] at this
  have e1 : (inner ℂ (invCLM hT h) k : ℂ)
      = inner ℂ (invCLM hT h) (invCLM hT k) + inner ℂ (invCLM hT h) (k - invCLM hT k) := by
    rw [← inner_add_right]; congr 1; abel
  have e2 : (inner ℂ h (invCLM hT k) : ℂ)
      = inner ℂ (invCLM hT h) (invCLM hT k) + inner ℂ (h - invCLM hT h) (invCLM hT k) := by
    rw [← inner_add_left]; congr 1; abel
  rw [e1, e2, e3]
