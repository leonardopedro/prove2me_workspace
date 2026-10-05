-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.eq_frExt_of_isSelfAdjointExtension
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.ClosureUniqueness
open BookProof.EsaClosure
open BookProof.FriedrichsSquare

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness


theorem BookProof.FriedrichsSquare.eq_frExt_of_isSelfAdjointExtension [CompleteSpace F] {A : D →ₗ[ℂ] F}
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) {hstab : ∀ v : D, (A v : F) ∈ D}
    {Dom : Submodule ℂ F} {B : Dom →ₗ[ℂ] F} (hB : IsSelfAdjointExtension (sqOp A hstab) B)
    (hdomle : Dom ≤ clDom A) :
    Dom = frDom A ∧ ∀ (x : F) (h₁ : x ∈ Dom) (h₂ : x ∈ frDom A),
      B ⟨x, h₁⟩ = frExt A hdense hsym ⟨x, h₂⟩ := by sorry
