-- Generated from ChapterPermutationSectorEsa.lean — solution of BookProof.PermSector.good_liftTail
import Mathlib
import Definitions.Def_ChapterPermutationSectorEsa
import Theorems.Thm_BookProof_TensorCore_tmul_mem_corePow
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
theorem solution {n : ℕ}
    {uD : ((domSpace Hs D₂).pow n).carrier ≃ₗᵢ[ℂ] ((domSpace Hs D₂).pow n).carrier}
    {uH : (Hs.pow n).carrier ≃ₗᵢ[ℂ] (Hs.pow n).carrier} (h : Good Hs D₂ A D n uD uH) :
    Good Hs D₂ A D (n + 1) (liftTail (domSpace Hs D₂) uD) (liftTail Hs uH) where
  incl t := by

    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, inclPow_tmul, inclPow_tmul, liftTail_tmul, h.incl]
    | add u v hu hv => simp only [map_add, hu, hv]
  der t := by
    induction t using TensorProduct.induction_on with
    | zero => simp
    | tmul a b =>
        rw [liftTail_tmul, derPow_tmul, derPow_tmul, map_add, liftTail_tmul, liftTail_tmul,
          h.incl, h.der]
    | add u v hu hv => simp only [map_add, hu, hv]
  core t ht := by
    induction ht using Submodule.span_induction with
    | mem u hu =>
        obtain ⟨a, haD, b, hb, rfl⟩ := hu
        rw [liftTail_tmul]
        exact tmul_mem_corePow Hs D₂ D haD (h.core b hb)
    | zero => simp
    | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
    | smul r u _ hu => rw [map_smul]; exact Submodule.smul_mem _ r hu
