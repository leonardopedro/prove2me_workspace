-- Generated from ChapterBosonicCCR.lean — solution of BookProof.Bosonic.commutator_field_Jfield
import Mathlib
import Definitions.Def_ChapterBosonicCCR
import Theorems.Thm_BookProof_ChapterF1_ccr
open BookProof.Bosonic



open RealInnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]
variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}

set_option maxHeartbeats 1000000 in
theorem solution (h : BosonicCCR J a) (hJsq : ∀ v, J (J v) = -v) (v : V) :
    a v * a (J v) - a (J v) * a v
      = algebraMap ℂ R (-(Complex.I * ((‖v‖ ^ 2 : ℝ) : ℂ))) := by

  rw [h.ccr v (J v), hJsq v]
  congr 1
  rw [inner_neg_right, real_inner_self_eq_norm_sq]
  push_cast; ring
