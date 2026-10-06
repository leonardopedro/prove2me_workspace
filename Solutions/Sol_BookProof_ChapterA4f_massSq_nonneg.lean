-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.massSq_nonneg
import Mathlib
import Definitions.Def_ChapterA4f
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (m₁ m₂ : ℝ) : 0 ≤ m₁ ^ 2 + m₂ ^ 2 := by

  positivity
