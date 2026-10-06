-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.preserves_prob_iff_isColumnStochastic
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.preserves_prob_iff_isColumnStochastic (M : Matrix (Fin 2) (Fin 2) ℝ) :
    (∀ v, IsProbabilityVector v → IsProbabilityVector (M.mulVec v))
      ↔ IsColumnStochastic M := by sorry
