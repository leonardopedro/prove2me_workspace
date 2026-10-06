-- Generated from ChapterBosonicCCR.lean — solution of BookProof.Bosonic.commutator_antiSelfAdjoint
import Mathlib
import Definitions.Def_ChapterBosonicCCR
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_selfAdjoint
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
theorem solution (h : BosonicCCR J a) (v w : V) :
    star (a v * a w - a w * a v) = -(a v * a w - a w * a v) := by

  rw [star_sub, star_mul, star_mul, h.selfAdjoint, h.selfAdjoint]; abel
