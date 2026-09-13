-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.isShiftInvertC_neg_of_isShiftInvert
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvertC_shift_apply
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {c : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A c R) : IsShiftInvertC A (-(c : ℂ)) (-R) := by

  constructor
  · intro x
    have hx : cshiftMap A (-(c : ℂ)) x = -(shiftMap A c x) := by
      simp only [cshiftMap_apply, shiftMap_apply, neg_smul]
      abel
    change (-R) (cshiftMap A (-(c : ℂ)) x) = (x : F)
    rw [hx]
    simp only [ContinuousLinearMap.neg_apply, map_neg, neg_neg]
    exact h.1 x
  · intro u
    have hmemneg : (-R) u ∈ Dom := by
      change -(R u) ∈ Dom
      exact Dom.neg_mem (h.mem u)
    refine ⟨hmemneg, ?_⟩
    have hval : A ⟨R u, h.mem u⟩ + (c : ℂ) • R u = u := h.shift_apply u
    have hcoe : (⟨(-R) u, hmemneg⟩ : Dom) = -(⟨R u, h.mem u⟩ : Dom) := Subtype.ext rfl
    rw [cshiftMap_apply, hcoe, map_neg]
    have hL : (-(c : ℂ)) • (((-(⟨R u, h.mem u⟩ : Dom)) : Dom) : F) - -A ⟨R u, h.mem u⟩
        = A ⟨R u, h.mem u⟩ + (c : ℂ) • R u := by
      simp only [Submodule.coe_neg]
      module
    rw [hL, hval]
