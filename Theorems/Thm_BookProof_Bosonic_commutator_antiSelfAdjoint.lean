-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.commutator_antiSelfAdjoint
import Mathlib
import Definitions.Def_ChapterBosonicCCR
import Definitions.Def_ChapterStoneConverse
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup
open BookProof.Bosonic

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]
variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}


open RealInnerProductSpace



theorem BookProof.Bosonic.commutator_antiSelfAdjoint (h : BosonicCCR J a) (v w : V) :
    star (a v * a w - a w * a v) = -(a v * a w - a w * a v) := by sorry
