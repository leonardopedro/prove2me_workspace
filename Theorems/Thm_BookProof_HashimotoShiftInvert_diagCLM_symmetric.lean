-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.diagCLM_symmetric
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.HashimotoShiftInvert
open scoped lp



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open scoped lp
open BookProof.HermiteGalerkin
open scoped lp
open Filter Topology
open scoped lp

theorem BookProof.HashimotoShiftInvert.diagCLM_symmetric {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x y : ℓ²(ℕ, ℂ)) :
    (inner ℂ (diagCLM hc x) y : ℂ) = inner ℂ x (diagCLM hc y) := by sorry
