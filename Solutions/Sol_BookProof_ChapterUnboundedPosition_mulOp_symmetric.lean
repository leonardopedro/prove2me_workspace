-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.mulOp_symmetric
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition

set_option maxHeartbeats 1000000 in
import Mathlib
import BookProof.ChapterContinuityUnitaryInfinite

theorem solution (f : ℤ → ℝ) (psi phi : mulDomain f) :
    ⟪mulOp f ps :=
  i, (phi : L2Z)⟫_ℂ = ⟪(psi : L2Z), mulOp f phi⟫_ℂ := by
    rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
    refine tsum_congr fun k => ?_
    simp only [mulOp_appl
