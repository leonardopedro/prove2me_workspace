-- Generated from ChapterE4.lean — theorem BookProof.ChapterE4.diag_collapse
import Mathlib
import Definitions.Def_ChapterE4
open BookProof.ChapterE4


open scoped BigOperators

theorem BookProof.ChapterE4.diag_collapse (θ : ℕ → ℝ) (s d i : ℕ) :
    (wave θ s (d + 1) i) ^ 2
      = Real.cos (θ s) ^ 2 * (basisVec s i) ^ 2
        + Real.sin (θ s) ^ 2 * (wave θ (s + 1) d i) ^ 2 := by sorry
