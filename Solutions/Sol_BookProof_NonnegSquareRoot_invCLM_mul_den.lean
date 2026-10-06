-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.invCLM_mul_den
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (hS : IsNonnegSelfAdjoint S)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ S ∧ (w, p.2) ∈ S) → p ∈ T) :
    invCLM hT * (1 - invCLM hS - invCLM hS + invCLM hS * invCLM hS + invCLM hS * invCLM hS)
      = invCLM hS * invCLM hS := by

  refine ContinuousLinearMap.ext fun h => ?_
  have h1 : (invCLM hS h, h - invCLM hS h) ∈ S := invCLM_mem hS h
  have h2 : (invCLM hS (invCLM hS h), invCLM hS h - invCLM hS (invCLM hS h)) ∈ S :=
    invCLM_mem hS (invCLM hS h)
  have h3 : (invCLM hS h - invCLM hS (invCLM hS h),
      (h - invCLM hS h) - (invCLM hS h - invCLM hS (invCLM hS h))) ∈ S := by
    have := S.sub_mem h1 h2
    simpa using this
  have h4 : (invCLM hS (invCLM hS h),
      (h - invCLM hS h) - (invCLM hS h - invCLM hS (invCLM hS h))) ∈ T :=
    hsq _ ⟨invCLM hS h - invCLM hS (invCLM hS h), h2, h3⟩
  have hval : invCLM hT (h - invCLM hS h - invCLM hS h + invCLM hS (invCLM hS h)
      + invCLM hS (invCLM hS h)) = invCLM hS (invCLM hS h) := by
    refine invCLM_eq_of_mem hT ?_
    have hrw : h - invCLM hS h - invCLM hS h + invCLM hS (invCLM hS h)
        + invCLM hS (invCLM hS h) - invCLM hS (invCLM hS h)
        = (h - invCLM hS h) - (invCLM hS h - invCLM hS (invCLM hS h)) := by abel
    rw [hrw]
    exact h4
  simpa [ContinuousLinearMap.mul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.sub_apply, ContinuousLinearMap.one_apply] using hval
