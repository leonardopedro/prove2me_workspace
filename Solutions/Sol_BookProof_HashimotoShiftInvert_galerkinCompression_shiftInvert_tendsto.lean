-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.galerkinCompression_shiftInvert_tendsto
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_mem
import Theorems.Thm_BookProof_HashimotoShiftInvert_IsShiftInvert_shift_apply
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinCompression_tendsto
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology
open BookProof.ChapterAbelianDiagonalCountable

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (b : HilbertBasis ℕ ℂ F) (u : F) :
    ∃ (x : F) (hx : x ∈ Dom), A ⟨x, hx⟩ + (γ : ℂ) • x = u ∧
      Tendsto (fun m : ℕ => galerkinCompression R b m u) atTop (nhds x) := ⟨R u, h.mem u, h.shift_apply u, galerkinCompression_tendsto R b u⟩
