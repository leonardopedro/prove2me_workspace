-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.ell2ShiftInvert_le_one
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

theorem BookProof.HashimotoShiftInvert.ell2ShiftInvert_le_one (v : ℓ²(ℕ, ℂ)) :
    (1 : ℝ) * ‖ell2ShiftInvert v‖ ^ 2 ≤ (inner ℂ (ell2ShiftInvert v) v : ℂ).re := by sorry
