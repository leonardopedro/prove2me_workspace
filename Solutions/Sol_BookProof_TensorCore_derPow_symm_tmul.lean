-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.derPow_symm_tmul
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_inner_tmul_pow
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
theorem solution (hA : SymmetricOn D₂ A) (n : ℕ)
    (ih : ∀ x y : ((domSpace Hs D₂).pow n),
      (inner ℂ (derPow Hs D₂ A n x) (inclPow Hs D₂ n y) : ℂ)
        = inner ℂ (inclPow Hs D₂ n x) (derPow Hs D₂ A n y))
    (a c : D₂) (b d : ((domSpace Hs D₂).pow n)) :
    (inner ℂ (derPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b)) (inclPow Hs D₂ (n + 1) (c ⊗ₜ[ℂ] d)) : ℂ)
      = inner ℂ (inclPow Hs D₂ (n + 1) (a ⊗ₜ[ℂ] b)) (derPow Hs D₂ A (n + 1) (c ⊗ₜ[ℂ] d)) := by

  rw [derPow_tmul, inclPow_tmul, inclPow_tmul, derPow_tmul]
  rw [inner_add_left, inner_add_right]
  rw [inner_tmul_pow Hs n (A a) ((c : Hs.carrier)),
    inner_tmul_pow Hs n ((a : Hs.carrier)) ((c : Hs.carrier)),
    inner_tmul_pow Hs n ((a : Hs.carrier)) (A c),
    inner_tmul_pow Hs n ((a : Hs.carrier)) ((c : Hs.carrier)),
    hA a c, ih b d]
