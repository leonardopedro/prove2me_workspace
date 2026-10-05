-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.cxConj_inner
import Mathlib
import Definitions.Def_Complexification



open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (x y : Cx W) :
    inner ℂ (cxConj x) (cxConj y) = starRingEnd ℂ (inner ℂ x y) := by

  simp only [inner_def, cxConj_apply]
  apply Complex.ext
  · simp [cxInner, inner_neg_left, inner_neg_right]
  · simp only [cxInner, inner_neg_left, inner_neg_right, Complex.conj_im]; ring
