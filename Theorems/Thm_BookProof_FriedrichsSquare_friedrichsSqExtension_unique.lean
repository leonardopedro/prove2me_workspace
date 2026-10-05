-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.friedrichsSqExtension_unique
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterFarisLavineCore
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.friedrichsSqExtension_unique [CompleteSpace F] {A : D →ₗ[ℂ] F}
    (hsym : SymmetricOn D A) {hstab : ∀ v : D, (A v : F) ∈ D} {R₁ R₂ : Submodule ℂ (F × F)}
    (h₁ : IsFriedrichsSqExtension A hstab R₁) (h₂ : IsFriedrichsSqExtension A hstab R₂) :
    R₁ = R₂ := by sorry
