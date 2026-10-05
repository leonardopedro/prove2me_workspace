-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.absOn_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
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
    absOn A hdense hsym x = 0 ↔ clExt A hdense hsym x = 0 := by

  rw [← norm_eq_zero, ← norm_eq_zero (a := clExt A hdense hsym x), norm_absOn]
