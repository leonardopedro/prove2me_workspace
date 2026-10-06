-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.euler_tsum_one
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.euler_tsum_one (θ : ℕ → ℝ)
    (htail : Tendsto (stickTail (condCos θ)) atTop (𝓝 0)) :
    ∑' n, stickProb (condCos θ) n = 1 := by sorry
