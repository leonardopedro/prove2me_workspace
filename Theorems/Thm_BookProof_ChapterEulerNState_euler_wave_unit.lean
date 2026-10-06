-- Generated from ChapterEulerNState.lean — theorem BookProof.ChapterEulerNState.euler_wave_unit
import Mathlib
import Definitions.Def_ChapterEulerNState
import Definitions.Def_ChapterDoubleSlit
open BookProof.ChapterDoubleSlit
open BookProof.ChapterEulerNState


open scoped BigOperators

theorem BookProof.ChapterEulerNState.euler_wave_unit (θ : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    ∑ k ∈ Finset.range n, (eulerWave θ n k) ^ 2 = 1 := by sorry
