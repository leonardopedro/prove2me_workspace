-- Generated from ChapterE4.lean — theorem BookProof.ChapterE4.density_recursion
import Mathlib
import Definitions.Def_ChapterE4
open BookProof.ChapterE4


open scoped BigOperators

theorem BookProof.ChapterE4.density_recursion (θ : ℕ → ℝ) (s d i j : ℕ) :
    wave θ s (d + 1) i * wave θ s (d + 1) j
      = Real.cos (θ s) ^ 2 * (basisVec s i * basisVec s j)
        + Real.sin (θ s) ^ 2 * (wave θ (s + 1) d i * wave θ (s + 1) d j)
        + Real.cos (θ s) * Real.sin (θ s) *
            (basisVec s i * wave θ (s + 1) d j + wave θ (s + 1) d i * basisVec s j) := by sorry
