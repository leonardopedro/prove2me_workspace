-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.isShiftInvert_unique
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_shift_apply
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R S : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hS : IsShiftInvert A γ S) : R = S := by

  ext u
  have h1 : S (shiftMap A γ ⟨R u, hR.mem u⟩) = R u := hS.1 ⟨R u, hR.mem u⟩
  rw [show shiftMap A γ ⟨R u, hR.mem u⟩ = u from hR.shift_apply u] at h1
  exact h1.symm
