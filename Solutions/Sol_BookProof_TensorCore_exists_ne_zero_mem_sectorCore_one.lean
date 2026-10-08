-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.exists_ne_zero_mem_sectorCore_one
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_tmul_mem_corePow
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section


/-! Helper: the elementary-tensor equations of `inclPow` / `derPow`.  The platform's
published `Def_ChapterTensorGraphCore` carries the definitions but not these three `rfl`
equations, and a solution may not rely on unpublished declarations, so they are stated
locally (this file is standalone: top-level `theorem solution` still follows). -/

@[simp] theorem inclPow_tmul (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (n : ℕ)
    (a : D₂) (b : ((domSpace Hs D₂).pow n)) :
    inclPow Hs D₂ (n + 1) (a ⊗ₜ[ℂ] b) = (a : Hs.carrier) ⊗ₜ[ℂ] inclPow Hs D₂ n b := rfl

@[simp] theorem derPow_zero (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
    (A : D₂ →ₗ[ℂ] Hs.carrier) (x : ((domSpace Hs D₂).pow 0)) :
    derPow Hs D₂ A 0 x = 0 := rfl

@[simp] theorem derPow_tmul (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
    (A : D₂ →ₗ[ℂ] Hs.carrier) (n : ℕ) (a : D₂) (b : ((domSpace Hs D₂).pow n)) :
    derPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b)
      = (A a) ⊗ₜ[ℂ] inclPow Hs D₂ n b + (a : Hs.carrier) ⊗ₜ[ℂ] derPow Hs D₂ A n b := rfl

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
