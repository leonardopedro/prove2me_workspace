-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.IsColumnStochastic.mulVec_isProbabilityVector
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.IsColumnStochastic.mulVec_isProbabilityVector
    {M : Matrix (Fin 2) (Fin 2) ℝ} (hM : IsColumnStochastic M)
    {v : Fin 2 → ℝ} (hv : IsProbabilityVector v) :
    IsProbabilityVector (M.mulVec v) := by sorry
