-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.hasZeroDeficiencyOn_top_of_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ F) (restrictToTop H) := by

  constructor
  · intro w hw
    have h := hw ⟨w, trivial⟩
    simp only [restrictToTop_apply, inner_smul_right] at h
    have hs : (inner ℂ (H w) w : ℂ) = inner ℂ w (H w) := hsym w w
    have hc : (inner ℂ w (H w) : ℂ) = starRingEnd ℂ (inner ℂ (H w) w) :=
      (inner_conj_symm _ _).symm
    have h2 : (2 * Complex.I) * (inner ℂ w w : ℂ) = 0 := by
      have hcc : starRingEnd ℂ (inner ℂ w w : ℂ) = inner ℂ w w := inner_self_conj _
      rw [h] at hs hc
      rw [hc] at hs
      simp only [map_mul, Complex.conj_I, hcc] at hs
      linear_combination hs
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))
  · intro w hw
    have h := hw ⟨w, trivial⟩
    simp only [restrictToTop_apply, inner_neg_right, inner_smul_right] at h
    have hs : (inner ℂ (H w) w : ℂ) = inner ℂ w (H w) := hsym w w
    have hc : (inner ℂ w (H w) : ℂ) = starRingEnd ℂ (inner ℂ (H w) w) :=
      (inner_conj_symm _ _).symm
    have h2 : (2 * Complex.I) * (inner ℂ w w : ℂ) = 0 := by
      have hcc : starRingEnd ℂ (inner ℂ w w : ℂ) = inner ℂ w w := inner_self_conj _
      rw [h] at hs hc
      rw [hc] at hs
      simp only [map_neg, map_mul, Complex.conj_I, hcc] at hs
      linear_combination -hs
    exact inner_self_eq_zero.mp ((mul_eq_zero.mp h2).resolve_left (by simp [Complex.I_ne_zero]))
