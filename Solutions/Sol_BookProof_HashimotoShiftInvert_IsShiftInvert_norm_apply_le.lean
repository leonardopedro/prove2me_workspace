-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvert.norm_apply_le
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_norm_shiftMap_ge
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_shift_apply
open BookProof.HashimotoShiftInvert
open BookProof.HashimotoShiftInvert.IsShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) (u : F) :
    ‖R u‖ ≤ γ⁻¹ * ‖u‖ := by

  have hb : γ * ‖((⟨R u, h.mem u⟩ : Dom) : F)‖ ≤ ‖shiftMap A γ ⟨R u, h.mem u⟩‖ :=
    norm_shiftMap_ge hpos _
  rw [show shiftMap A γ ⟨R u, h.mem u⟩ = u from h.shift_apply u] at hb
  rw [inv_mul_eq_div, le_div_iff₀ hγ, mul_comm]
  simpa using hb
