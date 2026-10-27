-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_coordUnit_apply
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : ℕ) (f : Ell2C) (j : ℕ) :
    ((diagOp (coordUnit i) f : Ell2C) : ℕ → ℂ) j = if j = i then (f : ℕ → ℂ) i else 0 := by

  rw [diagOp_apply]
  by_cases h : j = i
  · subst h; simp [coordUnit, lp.single_apply]
  · simp [coordUnit, lp.single_apply, h]
