-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.galerkinCompression_shiftInvert_tendsto
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_shift_apply
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinCompression_tendsto
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (b : HilbertBasis ℕ ℂ F) (u : F) :
    ∃ (x : F) (hx : x ∈ Dom), A ⟨x, hx⟩ + (γ : ℂ) • x = u ∧
      Tendsto (fun m : ℕ => galerkinCompression R b m u) atTop (nhds x) := ⟨R u, h.mem u, h.shift_apply u, galerkinCompression_tendsto R b u⟩
