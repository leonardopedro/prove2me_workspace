-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.stochastic_uniform_to_deterministic_not_isUnit
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.stochastic_uniform_to_deterministic_not_isUnit
    {M : Matrix (Fin 2) (Fin 2) ℝ} (hM : IsColumnStochastic M)
    (hMap : M.mulVec ![1 / 2, 1 / 2] = ![1, 0]) : ¬ IsUnit M := by sorry
