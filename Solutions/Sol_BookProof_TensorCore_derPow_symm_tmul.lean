-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.derPow_symm_tmul
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Theorems.Thm_BookProof_TensorCore_inner_tmul_pow
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

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
