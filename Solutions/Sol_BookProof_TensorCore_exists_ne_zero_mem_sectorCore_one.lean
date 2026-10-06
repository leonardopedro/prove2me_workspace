-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.exists_ne_zero_mem_sectorCore_one
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_tmul_mem_corePow
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hD : D ≤ D₂) {a : Hs.carrier} (haD : a ∈ D)
    (ha0 : a ≠ 0) : ∃ x ∈ sectorCore Hs D₂ D 1, x ≠ 0 := by

  refine ⟨inclPow Hs D₂ 1 ((⟨a, hD haD⟩ : D₂) ⊗ₜ[ℂ] (1 : ℂ)),
    ⟨(⟨a, hD haD⟩ : D₂) ⊗ₜ[ℂ] (1 : ℂ),
      tmul_mem_corePow Hs D₂ D (by simpa using haD) (by trivial), rfl⟩, ?_⟩
  have hnorm : ‖inclPow Hs D₂ 1 ((⟨a, hD haD⟩ : D₂) ⊗ₜ[ℂ] (1 : ℂ))‖ = ‖a‖ := by
    rw [inclPow_tmul]
    change ‖a ⊗ₜ[ℂ] inclPow Hs D₂ 0 (1 : ℂ)‖ = ‖a‖
    have h1 : inclPow Hs D₂ 0 (1 : ℂ) = (1 : ℂ) := rfl
    rw [h1, TensorProduct.norm_tmul]
    change ‖a‖ * ‖(1 : ℂ)‖ = ‖a‖
    simp
  intro hzero
  rw [hzero, norm_zero] at hnorm
  exact ha0 (norm_eq_zero.mp hnorm.symm)
