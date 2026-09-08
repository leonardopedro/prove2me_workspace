-- Generated from ChapterMajoranaClifford.lean — solution of BookProof.MajoranaClifford.a_anticomm_skew
import Mathlib
import Definitions.Def_ChapterMajoranaClifford
import Theorems.Thm_BookProof_MajoranaClifford_a_anticomm_of_orthogonal
open BookProof.MajoranaClifford










open RealInnerProductSpace CliffordAlgebra QuadraticMap


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

set_option maxHeartbeats 1000000 in
theorem solution (J : V →ₗ[ℝ] V) (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    a v * a (J v) + a (J v) * a v = 0 := by

  have h : ⟪v, J v⟫ = (0 : ℝ) := by
    have h1 : ⟪J v, v⟫ = -⟪v, J v⟫ := hJ v v
    have h2 : ⟪J v, v⟫ = ⟪v, J v⟫ := by rw [real_inner_comm]
    linarith [h1, h2]
  exact a_anticomm_of_orthogonal h
