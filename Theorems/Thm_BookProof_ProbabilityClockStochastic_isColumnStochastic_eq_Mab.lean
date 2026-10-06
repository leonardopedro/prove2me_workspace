-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.isColumnStochastic_eq_Mab
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.isColumnStochastic_eq_Mab {M : Matrix (Fin 2) (Fin 2) ℝ}
    (hM : IsColumnStochastic M) : ∃ a b, M = Mab a b := by sorry
