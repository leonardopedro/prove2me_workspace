-- Generated from ChapterAbelianAtomicCondensation.lean — solution of BookProof.ChapterAbelianAtomicCondensation.atomProj_apply
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
open BookProof.ChapterAbelianAtomicCondensation



open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable

set_option maxHeartbeats 1000000 in
theorem solution (i : ℕ) (f : Ell2C) : atomProj i f = (f : ℕ → ℂ) i • atom i := diagOp_coordUnit_eq i f
