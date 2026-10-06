-- Generated from ChapterEntropy.lean — theorem BookProof.ChapterEntropy.invertibleProb_isEquivalent_stirling
import Mathlib
import Definitions.Def_ChapterEntropy
open BookProof.ChapterEntropy



open Filter Asymptotics
open scoped Topology

theorem BookProof.ChapterEntropy.invertibleProb_isEquivalent_stirling :
    invertibleProb ~[atTop]
      (fun n : ℕ => Real.sqrt (2 * Real.pi * n) * Real.exp (-(n : ℝ))) := by sorry
