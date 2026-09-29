-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.shiftInvert_determines
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_apply_eq
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_dom_eq_range
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {Dom₁ Dom₂ : Submodule ℂ F} {A₁ : Dom₁ →ₗ[ℂ] F}
    {A₂ : Dom₂ →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h₁ : IsShiftInvert A₁ γ R) (h₂ : IsShiftInvert A₂ γ R) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (hx₁ : x ∈ Dom₁) (hx₂ : x ∈ Dom₂), A₁ ⟨x, hx₁⟩ = A₂ ⟨x, hx₂⟩ := by

  refine ⟨by rw [h₁.dom_eq_range, h₂.dom_eq_range], ?_⟩
  intro x hx₁ hx₂
  set u : F := shiftMap A₁ γ ⟨x, hx₁⟩ with hu
  have hRu : R u = x := h₁.1 ⟨x, hx₁⟩
  have e₁ : A₁ ⟨R u, h₁.mem u⟩ = u - (γ : ℂ) • R u := h₁.apply_eq u
  have e₂ : A₂ ⟨R u, h₂.mem u⟩ = u - (γ : ℂ) • R u := h₂.apply_eq u
  have c₁ : (⟨R u, h₁.mem u⟩ : Dom₁) = ⟨x, hx₁⟩ := Subtype.ext hRu
  have c₂ : (⟨R u, h₂.mem u⟩ : Dom₂) = ⟨x, hx₂⟩ := Subtype.ext hRu
  rw [c₁] at e₁
  rw [c₂] at e₂
  rw [e₁, e₂]
