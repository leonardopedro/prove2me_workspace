-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.ann_add_cre
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]
variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}


open RealInnerProductSpace



theorem BookProof.Bosonic.ann_add_cre (v : V) : ann a J v + cre a J v = a v + a v := by sorry
