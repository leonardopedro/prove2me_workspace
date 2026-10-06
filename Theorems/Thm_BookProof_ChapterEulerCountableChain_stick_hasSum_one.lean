-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.stick_hasSum_one
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.stick_hasSum_one (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1)
    (htail : Tendsto (stickTail c) atTop (𝓝 0)) :
    HasSum (stickProb c) 1 := by sorry
