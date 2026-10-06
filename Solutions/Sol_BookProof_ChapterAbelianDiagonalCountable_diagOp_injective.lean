-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_injective
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective diagOp := by

  intro d e h
  apply lp.ext
  funext i
  have := congrArg (fun T => ((T (lp.single 2 i (1 : ℂ)) : Ell2C) : ℕ → ℂ) i) h
  simpa using this
