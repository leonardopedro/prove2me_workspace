-- Generated from ChapterFriedrichsSquareFactorization.lean — solution of BookProof.FriedrichsSquare.frExt_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterFriedrichsSquareFactorization
open BookProof.FriedrichsSquare




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) (x : frDom A) :
    0 ≤ (inner ℂ (x : F) (frExt A hdense hsym x) : ℂ).re ∧
      (inner ℂ (x : F) (frExt A hdense hsym x) : ℂ).im = 0 := factorGraph_quadForm_nonneg (p := ((x : F), frFun A x)) (frFun_spec A x)
