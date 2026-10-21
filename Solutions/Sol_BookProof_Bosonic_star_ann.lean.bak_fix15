-- Generated from ChapterBosonicCCR.lean — solution of BookProof.Bosonic.star_ann
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
theorem solution (h : BosonicCCR J a) (v : V) : star (ann a J v) = cre a J v := by

  unfold ann cre
  rw [star_add, star_smul, h.selfAdjoint, h.selfAdjoint]
  simp [sub_eq_add_neg]
