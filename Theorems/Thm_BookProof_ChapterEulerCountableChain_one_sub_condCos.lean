-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.one_sub_condCos
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.one_sub_condCos (θ : ℕ → ℝ) (n : ℕ) :
    1 - condCos θ n = Real.sin (θ n) ^ 2 := by sorry
