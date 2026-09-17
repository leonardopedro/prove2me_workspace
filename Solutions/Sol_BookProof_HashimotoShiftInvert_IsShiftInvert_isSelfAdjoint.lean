-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvert.isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_shift_apply
open BookProof.HashimotoShiftInvert
open BookProof.HashimotoShiftInvert.IsShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace F] {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A) : IsSelfAdjoint R := by

  refine ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr ?_
  intro u v
  have hu : A ⟨R u, h.mem u⟩ + (γ : ℂ) • R u = u := h.shift_apply u
  have hv : A ⟨R v, h.mem v⟩ + (γ : ℂ) • R v = v := h.shift_apply v
  have hcross : (inner ℂ (A ⟨R u, h.mem u⟩) (R v) : ℂ)
      = inner ℂ (R u) (A ⟨R v, h.mem v⟩) := hsym ⟨R u, h.mem u⟩ ⟨R v, h.mem v⟩
  have e1 : (inner ℂ (R u) v : ℂ)
      = inner ℂ (R u) (A ⟨R v, h.mem v⟩) + (γ : ℂ) * inner ℂ (R u) (R v) := by
    conv_lhs => rw [← hv]
    rw [inner_add_right, inner_smul_right]
  have e2 : (inner ℂ u (R v) : ℂ)
      = inner ℂ (A ⟨R u, h.mem u⟩) (R v) + (γ : ℂ) * inner ℂ (R u) (R v) := by
    conv_lhs => rw [← hu]
    rw [inner_add_left, inner_smul_left]
    simp
  change (inner ℂ (R u) v : ℂ) = inner ℂ u (R v)
  rw [e1, e2, hcross]
