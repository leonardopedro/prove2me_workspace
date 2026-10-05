-- Generated from ChapterPositiveSquareRootUnique.lean — theorem BookProof.PositiveSquareRoot.invCLM_eq_cfc
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
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder


theorem BookProof.PositiveSquareRoot.invCLM_eq_cfc (A : D →ₗ[ℂ] F) (hT : IsNonnegSelfAdjoint T)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T) → p ∈ factorRel A) :
    invCLM hT = cfc psiFun (resCLM A) := by sorry
