-- Generated from ChapterEulerStochastic.lean — theorem BookProof.ChapterEulerStochastic.preservesProb_iff_columnStochastic
import Mathlib
import Definitions.Def_ChapterEulerStochastic
open BookProof.ChapterEulerStochastic


open scoped Matrix BigOperators

theorem BookProof.ChapterEulerStochastic.preservesProb_iff_columnStochastic (M : Matrix (Fin 2) (Fin 2) ℝ) :
    PreservesProb M ↔
      (IsProbVec (fun i => M i 0) ∧ IsProbVec (fun i => M i 1)) := by sorry
