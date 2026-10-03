-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.inner_shiftOp_left
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite

set_option maxHeartbeats 1000000 in
open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterContinuityUnitaryInfinite

/-! ## The lattice Hilbert space and the `ℓ^∞` velocity fields -/

/-- The infinite lattice Hilbert space `ℓ²(ℤ)`. -/
noncomputable abbrev L2Z :=
  iftOp (-m) g⟫_ℂ := by
    have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
    have hg : shiftEquiv m (shiftLin (-m) g) = g := by
      ext k
      change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
      simp only [add_neg_cancel_right]
    rw
