-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.preIsom_apply
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

set_option maxHeartbeats 1000000 in
theorem solution (x : Dom) :
    preIsom P Q h ⟨P x, LinearMap.mem_range_self P x⟩ = Q x := (Classical.choose_spec (exists_linearIsometry_of_inner_eq P Q h)).1 x
