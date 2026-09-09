-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.shiftInvertC_determines
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_apply_eq
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_dom_eq_range
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {Dom₁ Dom₂ : Submodule ℂ F} {A₁ : Dom₁ →ₗ[ℂ] F}
    {A₂ : Dom₂ →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h₁ : IsShiftInvertC A₁ γ X) (h₂ : IsShiftInvertC A₂ γ X) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (hx₁ : x ∈ Dom₁) (hx₂ : x ∈ Dom₂), A₁ ⟨x, hx₁⟩ = A₂ ⟨x, hx₂⟩ := by

  refine ⟨by rw [h₁.dom_eq_range, h₂.dom_eq_range], ?_⟩
  intro x hx₁ hx₂
  set u : F := cshiftMap A₁ γ ⟨x, hx₁⟩ with hu
  have hXu : X u = x := h₁.1 ⟨x, hx₁⟩
  have e₁ : A₁ ⟨X u, h₁.mem u⟩ = γ • X u - u := h₁.apply_eq u
  have e₂ : A₂ ⟨X u, h₂.mem u⟩ = γ • X u - u := h₂.apply_eq u
  have c₁ : (⟨X u, h₁.mem u⟩ : Dom₁) = ⟨x, hx₁⟩ := Subtype.ext hXu
  have c₂ : (⟨X u, h₂.mem u⟩ : Dom₂) = ⟨x, hx₂⟩ := Subtype.ext hXu
  rw [c₁] at e₁
  rw [c₂] at e₂
  rw [e₁, e₂]
