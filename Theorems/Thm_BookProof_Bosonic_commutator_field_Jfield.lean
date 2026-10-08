-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.commutator_field_Jfield
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic


open RealInnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]

variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}

theorem BookProof.Bosonic.commutator_field_Jfield (h : BosonicCCR J a) (hJsq : ∀ v, J (J v) = -v) (v : V) :
    a v * a (J v) - a (J v) * a v
      = algebraMap ℂ R (-(Complex.I * ((‖v‖ ^ 2 : ℝ) : ℂ))) := by sorry
