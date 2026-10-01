-- Generated from ChapterNavierStokesHashimoto.lean — solution of BookProof.NavierStokesFlow.NSHashimoto.ns_shiftInvert_selects
import Mathlib
import Definitions.Def_ChapterNavierStokesHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_NSHashimoto_ns_selfAdjoint_extension
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_dom_eq_range
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_opNorm_le
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftMap_surjective
import Theorems.Thm_BookProof_HashimotoShiftInvert_exists_isShiftInvertC
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftInvertC_determines
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.NSHashimoto



open Filter Topology



open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {γ : ℂ} (hγ : γ.im ≠ 0) :
    ∃ (Dom : Submodule ℂ (L2I Vel)) (G : Dom →ₗ[ℂ] L2I Vel) (X : L2I Vel →L[ℂ] L2I Vel),
      IsSelfAdjointExtension (velCore A c) G ∧ IsShiftInvertC G γ X ∧
      ‖X‖ ≤ |γ.im|⁻¹ ∧ Dom = LinearMap.range ((X : L2I Vel →ₗ[ℂ] L2I Vel)) ∧
      (∀ (Dom' : Submodule ℂ (L2I Vel)) (G' : Dom' →ₗ[ℂ] L2I Vel), IsShiftInvertC G' γ X →
        Dom' = Dom ∧ ∀ (x : L2I Vel) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
          G' ⟨x, hx'⟩ = G ⟨x, hx⟩) := by

  obtain ⟨Dom, G, hG⟩ := ns_selfAdjoint_extension A c
  obtain ⟨hext, hsym, hsa⟩ := hG
  obtain ⟨X, hX⟩ := exists_isShiftInvertC hsym hγ (cshiftMap_surjective hsym hsa hγ)
  refine ⟨Dom, G, X, ⟨hext, hsym, hsa⟩, hX, hX.opNorm_le hsym hγ, hX.dom_eq_range, ?_⟩
  intro Dom' G' hG'
  obtain ⟨hdom, hval⟩ := shiftInvertC_determines hG' hX
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩
