-- Generated from ChapterPolarPartialIsometry.lean — solution of BookProof.PolarPartialIsometry.inner_eq_of_norm_eq_clm
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
open BookProof.PolarPartialIsometry




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}
variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (S T : F →L[ℂ] F) (hnorm : ∀ z, ‖S z‖ = ‖T z‖) (z w : F) :
    (inner ℂ (S z) (S w) : ℂ) = inner ℂ (T z) (T w) := by

  have key : ∀ c : ℂ, ‖S z + c • S w‖ = ‖T z + c • T w‖ := by
    intro c
    have hS : S z + c • S w = S (z + c • w) := by rw [map_add, map_smul]
    have hT : T z + c • T w = T (z + c • w) := by rw [map_add, map_smul]
    rw [hS, hT, hnorm]
  have e1 : ‖S z + S w‖ = ‖T z + T w‖ := by simpa using key 1
  have e2 : ‖S z - S w‖ = ‖T z - T w‖ := by
    have := key (-1); simpa [sub_eq_add_neg] using this
  have e3 : ‖S z - (RCLike.I : ℂ) • S w‖ = ‖T z - (RCLike.I : ℂ) • T w‖ := by
    have := key (-(RCLike.I : ℂ)); simpa [sub_eq_add_neg] using this
  have e4 : ‖S z + (RCLike.I : ℂ) • S w‖ = ‖T z + (RCLike.I : ℂ) • T w‖ := key _
  rw [inner_eq_sum_norm_sq_div_four, inner_eq_sum_norm_sq_div_four, e1, e2, e3, e4]
