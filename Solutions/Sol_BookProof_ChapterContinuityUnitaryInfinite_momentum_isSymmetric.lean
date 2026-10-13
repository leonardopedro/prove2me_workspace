-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.momentum_isSymmetric
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_inner_shiftOp_left
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace lp

set_option maxHeartbeats 1000000 in
theorem solution : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring
