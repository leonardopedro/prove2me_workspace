-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.diagCLM_norm_apply_le
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.HashimotoShiftInvert



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

theorem BookProof.HashimotoShiftInvert.diagCLM_norm_apply_le {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x : ℓ²(ℕ, ℂ)) :
    ‖diagCLM hc x‖ ≤ ‖x‖ := by sorry
