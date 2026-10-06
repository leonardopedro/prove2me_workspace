-- Generated from ChapterBosonicCCR.lean — solution of BookProof.Bosonic.symplectic_self
import Mathlib
import Definitions.Def_ChapterBosonicCCR
import Theorems.Thm_BookProof_Bosonic_symplectic_antisymm
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
theorem solution (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    (⟪v, J v⟫ : ℝ) = 0 := by

  have := symplectic_antisymm hJ v v; linarith
