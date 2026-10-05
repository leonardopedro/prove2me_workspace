-- Generated from ChapterFriedrichsSquareFactorization.lean — theorem BookProof.FriedrichsSquare.isFriedrichsSqExtension_factorRel
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


theorem BookProof.FriedrichsSquare.isFriedrichsSqExtension_factorRel [CompleteSpace F] (A : D →ₗ[ℂ] F)
    (hsym : SymmetricOn D A) (hstab : ∀ v : D, (A v : F) ∈ D) :
    IsFriedrichsSqExtension A hstab (factorRel A) where
  extends_sq v := by sorry
