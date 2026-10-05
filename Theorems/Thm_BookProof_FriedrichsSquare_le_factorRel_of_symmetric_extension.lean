-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.le_factorRel_of_symmetric_extension
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


theorem BookProof.FriedrichsSquare.le_factorRel_of_symmetric_extension {A : D →ₗ[ℂ] F} (hsym : SymmetricOn D A)
    {hstab : ∀ v : D, (A v : F) ∈ D} {R : Submodule ℂ (F × F)}
    (hext : ∀ v : D, ((v : F), sqOp A hstab v) ∈ R)
    (hRsym : ∀ p ∈ R, ∀ q ∈ R, (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2)
    (hdom : ∀ p ∈ R, p.1 ∈ clDom A) : R ≤ factorRel A := by sorry
