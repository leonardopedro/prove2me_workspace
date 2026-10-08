-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.field_commute_self_scalar
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic


open RealInnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]

variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}

theorem BookProof.Bosonic.field_commute_self_scalar (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    algebraMap ℂ R (Complex.I * (⟪v, J v⟫ : ℂ)) = 0 := by sorry
