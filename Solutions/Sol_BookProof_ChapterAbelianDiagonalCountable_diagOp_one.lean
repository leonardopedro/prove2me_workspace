-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_one
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in


@[simp] private theorem diagOp_apply (d : EllInf) (f : Ell2C) (i : ℕ) :
    ((diagOp d f : Ell2C) : ℕ → ℂ) i = (d : ℕ → ℂ) i * (f : ℕ → ℂ) i := rfl

theorem solution : diagOp (1 : EllInf) = ContinuousLinearMap.id ℂ Ell2C := by
  ext f i
  simp
