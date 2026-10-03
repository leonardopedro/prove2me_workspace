-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.mulOp_symmetric
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition

open scoped ENNReal InnerProductSpace lp

namespace BookProof.ChapterUnboundedPosition

open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

/-! ## The natural domain of a multiplication operator -/

/-- The **natural domain** `D(f) = {ψ ∈ ℓ²(ℤ) : f·ψ ∈ ℓ²(ℤ)}` of multiplication
by a real field `f`, as a submodule of `ℓ²(ℤ)`. -/
def mulDomain (f : ℤ → ℝ) : Submodule ℂ L2Z where
  carrier := by sorry
