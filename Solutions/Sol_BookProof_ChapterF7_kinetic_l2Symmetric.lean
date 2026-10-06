-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.kinetic_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_ChapterF7_momentum_l2Symmetric
import Theorems.Thm_BookProof_ChapterF7_smul_l2Symmetric
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : IsL2Symmetric kinetic := by

  refine smul_l2Symmetric (by simp only [map_div₀, map_one, map_ofNat]) ?_
  intro f g
  simp only [ContinuousLinearMap.comp_apply]
  rw [momentum_l2Symmetric, momentum_l2Symmetric]
