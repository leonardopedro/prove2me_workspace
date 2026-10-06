-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.mulOp_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_apply
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    IsL2Symmetric (mulOp v hv) := by

  intro f g
  unfold l2pair
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [mulOp_apply, map_mul, Complex.conj_ofReal]
  ring
