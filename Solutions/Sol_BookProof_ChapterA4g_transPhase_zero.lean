-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.transPhase_zero
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin 3 → ℝ) : transPhase p 0 = 1 := by

  unfold transPhase; norm_num
