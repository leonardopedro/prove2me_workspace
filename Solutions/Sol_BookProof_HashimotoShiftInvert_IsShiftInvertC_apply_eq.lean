-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvertC.apply_eq
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_shift_apply
open BookProof.HashimotoShiftInvert
open BookProof.HashimotoShiftInvert.IsShiftInvertC



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) (u : F) :
    A ⟨X u, h.mem u⟩ = γ • X u - u := by

  have h1 : γ • X u - A ⟨X u, h.mem u⟩ = u := h.shift_apply u
  have ha : γ • X u = u + A ⟨X u, h.mem u⟩ := sub_eq_iff_eq_add.mp h1
  rw [ha]; abel
