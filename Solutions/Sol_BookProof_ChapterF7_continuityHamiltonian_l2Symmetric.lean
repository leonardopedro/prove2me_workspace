-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.continuityHamiltonian_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_ChapterF7_mulOp_l2Symmetric
import Theorems.Thm_BookProof_ChapterF7_momentum_l2Symmetric
import Theorems.Thm_BookProof_ChapterF7_anticomm_l2Symmetric
import Theorems.Thm_BookProof_ChapterF7_smul_l2Symmetric
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (v : ℝ → ℝ)
    (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    IsL2Symmetric
      (((1 : ℂ) / 2) • (momentum.comp (mulOp v hv) + (mulOp v hv).comp momentum)) := by

  refine smul_l2Symmetric (by simp only [map_div₀, map_one, map_ofNat])
    (anticomm_l2Symmetric momentum_l2Symmetric (mulOp_l2Symmetric v hv))
