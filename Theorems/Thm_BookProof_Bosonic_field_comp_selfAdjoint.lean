-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.field_comp_selfAdjoint
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



theorem BookProof.Bosonic.field_comp_selfAdjoint (h : BosonicCCR J a) (T : V →ₗ[ℝ] V) (v : V) :
    star (a (T v)) = a (T v) := by sorry
