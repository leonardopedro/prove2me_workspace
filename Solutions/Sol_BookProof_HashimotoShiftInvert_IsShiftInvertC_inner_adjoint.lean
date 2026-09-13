-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvertC.inner_adjoint
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
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A ((starRingEnd ℂ) γ) Y)
    (hsym : SymmetricOn Dom A) (u v : F) :
    (inner ℂ (X u) v : ℂ) = inner ℂ u (Y v) := by

  have hu : γ • X u - A ⟨X u, hX.mem u⟩ = u := hX.shift_apply u
  have hv : (starRingEnd ℂ) γ • Y v - A ⟨Y v, hY.mem v⟩ = v := hY.shift_apply v
  have hcross : (inner ℂ (A ⟨X u, hX.mem u⟩) (Y v) : ℂ)
      = inner ℂ (X u) (A ⟨Y v, hY.mem v⟩) :=
    hsym ⟨X u, hX.mem u⟩ ⟨Y v, hY.mem v⟩
  have e1 : (inner ℂ (X u) v : ℂ)
      = (starRingEnd ℂ) γ * inner ℂ (X u) (Y v) - inner ℂ (X u) (A ⟨Y v, hY.mem v⟩) := by
    conv_lhs => rw [← hv]
    rw [inner_sub_right, inner_smul_right]
  have e2 : (inner ℂ u (Y v) : ℂ)
      = (starRingEnd ℂ) γ * inner ℂ (X u) (Y v) - inner ℂ (A ⟨X u, hX.mem u⟩) (Y v) := by
    conv_lhs => rw [← hu]
    rw [inner_sub_left, inner_smul_left]
  rw [e1, e2, hcross]
