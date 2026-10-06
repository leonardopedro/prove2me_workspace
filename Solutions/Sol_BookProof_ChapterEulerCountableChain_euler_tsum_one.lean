-- Generated from ChapterEulerCountableChain.lean — solution of BookProof.ChapterEulerCountableChain.euler_tsum_one
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
import Theorems.Thm_BookProof_ChapterEulerCountableChain_stick_tsum_one
import Theorems.Thm_BookProof_ChapterEulerCountableChain_condCos_mem
open BookProof.ChapterEulerCountableChain



open scoped BigOperators
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ)
    (htail : Tendsto (stickTail (condCos θ)) atTop (𝓝 0)) :
    ∑' n, stickProb (condCos θ) n = 1 := stick_tsum_one (condCos θ) (condCos_mem θ) htail
