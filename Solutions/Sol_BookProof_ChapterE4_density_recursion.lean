-- Generated from ChapterE4.lean — solution of BookProof.ChapterE4.density_recursion
import Mathlib
import Definitions.Def_ChapterE4
import Theorems.Thm_BookProof_ChapterE4_wave_succ
open BookProof.ChapterE4



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (s d i j : ℕ) :
    wave θ s (d + 1) i * wave θ s (d + 1) j
      = Real.cos (θ s) ^ 2 * (basisVec s i * basisVec s j)
        + Real.sin (θ s) ^ 2 * (wave θ (s + 1) d i * wave θ (s + 1) d j)
        + Real.cos (θ s) * Real.sin (θ s) *
            (basisVec s i * wave θ (s + 1) d j + wave θ (s + 1) d i * basisVec s j) := by

  rw [ wave_succ, wave_succ ] ; ring
