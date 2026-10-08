-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.ccr_symplectic_invariant
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic


open RealInnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]

variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}

theorem BookProof.Bosonic.ccr_symplectic_invariant (h : BosonicCCR J a) (T : V →ₗ[ℝ] V)
    (hT : ∀ v w : V, (⟪T v, J (T w)⟫ : ℝ) = ⟪v, J w⟫) (v w : V) :
    a (T v) * a (T w) - a (T w) * a (T v)
      = algebraMap ℂ R (Complex.I * (⟪v, J w⟫ : ℂ)) := by sorry
