-- Generated from ChapterUnboundedPosition.lean — solution of BookProof.ChapterUnboundedPosition.mulOp_symmetric
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnboundedPosition

set_option maxHeartbeats 1000000 in
open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterUnboundedPosition

open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

/-! ## The natural domain of a multiplication operator -/

/-- The **natural domain** `D(f) = {ψ ∈ ℓ²(ℤ) : f·ψ ∈ ℓ²(ℤ)}` of multiplication
by a real field `f`, as a submodule of `ℓ²(ℤ)`. -/
def mulDomain (f : ℤ → ℝ) : Submodule ℂ L2Z where
  carrier :=
  i, (phi : L2Z)⟫_ℂ = ⟪(psi : L2Z), mulOp f phi⟫_ℂ := by
    rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
    refine tsum_congr fun k => ?_
    simp only [mulOp_appl
