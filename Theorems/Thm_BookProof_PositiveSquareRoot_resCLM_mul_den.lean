-- Generated from ChapterPositiveSquareRootUnique.lean — theorem BookProof.PositiveSquareRoot.resCLM_mul_den
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterStoneResolvent
open BookProof.PositiveSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder


theorem BookProof.PositiveSquareRoot.resCLM_mul_den (A : D →ₗ[ℂ] F) (hT : IsNonnegSelfAdjoint T)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T) → p ∈ factorRel A) :
    resCLM A * (1 - invCLM hT - invCLM hT + invCLM hT * invCLM hT + invCLM hT * invCLM hT)
      = invCLM hT * invCLM hT := by sorry
