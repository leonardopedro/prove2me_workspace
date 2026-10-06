-- Generated from ChapterEntropy.lean — theorem BookProof.ChapterEntropy.invertibleProb_eq
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy



open Filter Asymptotics
open scoped Topology

theorem BookProof.ChapterEntropy.invertibleProb_eq (n : ℕ) :
    invertibleProb n = (Nat.factorial n : ℝ) / (n ^ n : ℝ) := by sorry
