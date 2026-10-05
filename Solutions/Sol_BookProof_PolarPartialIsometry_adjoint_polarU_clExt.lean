-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.adjoint_polarU_clExt
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
import Theorems.Thm_BookProof_PolarPartialIsometry_adjoint_polarIsom_apply
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]
variable [CompleteSpace F] {D : Submodule ℂ F} (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
  (hsym : SymmetricOn D A)

set_option maxHeartbeats 1000000 in
theorem solution (x : clDom A) :
    ContinuousLinearMap.adjoint (polarU A hdense hsym) (clExt A hdense hsym x)
      = absOn A hdense hsym x := adjoint_polarIsom_apply _ _ _ x
