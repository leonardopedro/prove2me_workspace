-- Generated from ChapterComplexShiftCore.lean — theorem BookProof.HashimotoShiftInvert.norm_cshiftMap_ge
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}



open BookProof.FarisLavine
open Filter Topology

theorem BookProof.HashimotoShiftInvert.norm_cshiftMap_ge {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A) (γ : ℂ) (x : Dom) :
    |γ.im| * ‖(x : F)‖ ≤ ‖cshiftMap A γ x‖ := by sorry
