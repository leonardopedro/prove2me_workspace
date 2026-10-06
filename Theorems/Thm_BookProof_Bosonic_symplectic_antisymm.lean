-- Generated from ChapterBosonicCCR.lean — theorem BookProof.Bosonic.symplectic_antisymm
import Mathlib
import Definitions.Def_ChapterBosonicCCR
open BookProof.Bosonic

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]
variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}


open RealInnerProductSpace



theorem BookProof.Bosonic.symplectic_antisymm (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v w : V) :
    (⟪v, J w⟫ : ℝ) = -⟪w, J v⟫ := by sorry
