-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.invCLM_eq_cfc
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_nonneg
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_le_one
import Theorems.Thm_BookProof_PositiveSquareRoot_resCLM_mul_den
import Theorems.Thm_BookProof_PositiveSquareRoot_eq_cfc_psiFun
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterStoneResolvent
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hT : IsNonnegSelfAdjoint T)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T) → p ∈ factorRel A) :
    invCLM hT = cfc psiFun (resCLM A) :=
  eq_cfc_psiFun (invCLM hT) (resCLM A) (invCLM_nonneg hT) (invCLM_le_one hT)
      (resCLM_mul_den A hT hsq)
