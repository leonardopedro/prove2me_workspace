-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.symplectic_self
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic


open RealInnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]

variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}

theorem BookProof.Bosonic.symplectic_self (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    (⟪v, J v⟫ : ℝ) = 0 := by sorry
