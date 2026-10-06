-- Generated from ChapterBijectionProbability.lean — theorem BookProof.ChapterBijectionProbability.bijProb_isEquivalent_stirling
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability


open scoped Nat
open Filter Asymptotics

theorem BookProof.ChapterBijectionProbability.bijProb_isEquivalent_stirling :
    IsEquivalent atTop bijProb
      (fun n => Real.sqrt (2 * n * Real.pi) * Real.exp (-(n : ℝ))) := by sorry
