-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.resCLM_mul_den
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
import Theorems.Thm_BookProof_VonNeumannCore_resCLM_apply
import Theorems.Thm_BookProof_VonNeumannCore_resLin_apply
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hT : IsNonnegSelfAdjoint T)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T) → p ∈ factorRel A) :
    resCLM A * (1 - invCLM hT - invCLM hT + invCLM hT * invCLM hT + invCLM hT * invCLM hT)
      = invCLM hT * invCLM hT := by

  refine ContinuousLinearMap.ext fun h => ?_
  have h1 : (invCLM hT h, h - invCLM hT h) ∈ T := invCLM_mem hT h
  have h2 : (invCLM hT (invCLM hT h), invCLM hT h - invCLM hT (invCLM hT h)) ∈ T :=
    invCLM_mem hT (invCLM hT h)
  have h3 : (invCLM hT h - invCLM hT (invCLM hT h),
      (h - invCLM hT h) - (invCLM hT h - invCLM hT (invCLM hT h))) ∈ T := by
    have := T.sub_mem h1 h2
    simpa using this
  have h4 : (invCLM hT (invCLM hT h),
      (h - invCLM hT h) - (invCLM hT h - invCLM hT (invCLM hT h))) ∈ factorRel A :=
    hsq _ ⟨invCLM hT h - invCLM hT (invCLM hT h), h2, h3⟩
  have hsum : invCLM hT (invCLM hT h)
      + ((h - invCLM hT h) - (invCLM hT h - invCLM hT (invCLM hT h)))
      = h - invCLM hT h - invCLM hT h + invCLM hT (invCLM hT h)
        + invCLM hT (invCLM hT h) := by abel
  have hres := resPair_unique (A := A) h4 hsum
  have hval : resCLM A (h - invCLM hT h - invCLM hT h + invCLM hT (invCLM hT h)
      + invCLM hT (invCLM hT h)) = invCLM hT (invCLM hT h) := by
    rw [resCLM_apply, resLin_apply, hres]
  simpa [ContinuousLinearMap.mul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.sub_apply, ContinuousLinearMap.one_apply] using hval
