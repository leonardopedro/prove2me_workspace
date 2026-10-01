-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.inner_single_left
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition



open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

set_option maxHeartbeats 1000000 in
t: the maximal multiplication operator is self-adjoint -/

theorem solution (phi : L2Z) (k : ℤ) (c : ℂ) :
    ⟪(lp.single 2 k c : L2Z) :=
  , phi⟫_ℂ = (starRingEnd ℂ) c * (phi : ℤ → ℂ) k := by
    rw [lp.inner_eq_tsum, tsum_eq_single k (by intro j hj; simp [lp.single_apply, h
