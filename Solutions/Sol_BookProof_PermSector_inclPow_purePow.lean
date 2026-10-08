-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.inclPow_purePow
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
open BookProof.PermSector




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm

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

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (n : ℕ) (f : Fin n → D₂),
    inclPow Hs D₂ n (purePow (domSpace Hs D₂) n f)
      = purePow Hs n (fun i => ((f i : Hs.carrier))) := by

  intro n
  induction n with
  | zero => intro f; rfl
  | succ n ih =>
      intro f
      rw [purePow_succ, inclPow_tmul, ih, purePow_succ]
      rfl
