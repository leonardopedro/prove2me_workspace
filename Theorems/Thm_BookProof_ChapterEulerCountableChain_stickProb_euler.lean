-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.stickProb_euler
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.stickProb_euler (θ : ℕ → ℝ) (n : ℕ) :
    stickProb (condCos θ) n
      = (∏ k ∈ Finset.range n, Real.sin (θ k) ^ 2) * Real.cos (θ n) ^ 2 := by sorry
