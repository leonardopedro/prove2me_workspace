-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.rotMat_eq_exp
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
import Definitions.Def_ChapterEulerGenericDensity
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.ChapterEulerGenericDensity
open BookProof.FullQuadratic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.rotMat_eq_exp (a : ℝ) :
    NormedSpace.exp (a • Jgen) = rotMat a := by sorry
