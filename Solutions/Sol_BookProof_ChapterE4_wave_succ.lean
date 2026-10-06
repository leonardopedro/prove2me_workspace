-- Generated from ChapterE4.lean — solution of BookProof.ChapterE4.wave_succ
import Mathlib
import Definitions.Def_ChapterE4
open BookProof.ChapterE4



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (s d : ℕ) (i : ℕ) :
    wave θ s (d + 1) i =
      Real.cos (θ s) * basisVec s i + Real.sin (θ s) * wave θ (s + 1) d i := rfl
