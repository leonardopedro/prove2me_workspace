-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.mulOp_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.mulOp_l2Symmetric (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    IsL2Symmetric (mulOp v hv) := by sorry
