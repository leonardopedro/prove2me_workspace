-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvertC.injective
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
    (h : IsShiftInvertC A γ X) : Function.Injective X := by

  intro u v huv
  have hu := h.shift_apply u
  have hv := h.shift_apply v
  have hsub : (⟨X u, h.mem u⟩ : Dom) = ⟨X v, h.mem v⟩ := Subtype.ext huv
  rw [← hu, ← hv, hsub, huv]
