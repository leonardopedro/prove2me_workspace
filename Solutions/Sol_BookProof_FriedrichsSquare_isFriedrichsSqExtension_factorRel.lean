-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.isFriedrichsSqExtension_factorRel
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Theorems.Thm_BookProof_FriedrichsSquare_fst_mem_clDom_of_mem_factorRel
import Theorems.Thm_BookProof_FriedrichsSquare_adjPairs_factorRel
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] (A : D →ₗ[ℂ] F)
    (hsym : SymmetricOn D A) (hstab : ∀ v : D, (A v : F) ∈ D) :
    IsFriedrichsSqExtension A hstab (factorRel A) where
  extends_sq v :=
  where
    extends_sq v := mem_factorGraph_sqOp A hsym hstab v
    form_domain _ hp := fst_mem_clDom_of_mem_factorRel hp
    selfAdjoint := adjPairs_factorRel A
