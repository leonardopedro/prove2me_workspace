-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.commutator_cre_ann
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]
variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}


open RealInnerProductSpace



theorem BookProof.Bosonic.commutator_cre_ann (h : BosonicCCR J a) (hJsq : ∀ v, J (J v) = -v) (v : V) :
    cre a J v * ann a J v - ann a J v * cre a J v
      = algebraMap ℂ R ((2 * (‖v‖ ^ 2 : ℝ) : ℂ)) := by sorry
