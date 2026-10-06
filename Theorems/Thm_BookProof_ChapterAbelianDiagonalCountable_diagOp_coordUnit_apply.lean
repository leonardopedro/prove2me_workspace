-- Generated from ChapterAbelianDiagonalCountable.lean — theorem BookProof.ChapterAbelianDiagonalCountable.diagOp_coordUnit_apply
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable


open scoped ENNReal

noncomputable section

theorem BookProof.ChapterAbelianDiagonalCountable.diagOp_coordUnit_apply (i : ℕ) (f : Ell2C) (j : ℕ) :
    ((diagOp (coordUnit i) f : Ell2C) : ℕ → ℂ) j = if j = i then (f : ℕ → ℂ) i else 0 := by sorry
