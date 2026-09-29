-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.symmetric_hasZeroDeficiency
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiency H := by

  constructor
  · intro v hv
    have h := hsym v v
    rw [hv, inner_smul_left, inner_smul_right] at h
    have h2 : (2 * Complex.I) * (inner ℂ v v : ℂ) = 0 := by
      simp only [Complex.conj_I] at h
      linear_combination -h
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))
  · intro v hv
    have h := hsym v v
    rw [hv, inner_neg_left, inner_neg_right, inner_smul_left, inner_smul_right] at h
    have h2 : (2 * Complex.I) * (inner ℂ v v : ℂ) = 0 := by
      simp only [Complex.conj_I] at h
      linear_combination h
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))
