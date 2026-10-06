-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.invCLM_eq_cfc_of_sq
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLM_mul_den
import Theorems.Thm_BookProof_PositiveSquareRoot_eq_cfc_psiFun
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_le_one
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_nonneg
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
    invCLM hS = cfc psiFun (invCLM hT) :=
  eq_cfc_psiFun (invCLM hS) (invCLM hT) (invCLM_nonneg hS) (invCLM_le_one hS)
      (invCLM_mul_den hT hS hsq)
