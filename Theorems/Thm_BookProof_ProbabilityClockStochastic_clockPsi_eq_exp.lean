-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.clockPsi_eq_exp
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
import Definitions.Def_ChapterEulerDensityMatrix
import Definitions.Def_ChapterEulerGenericDensity
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.ChapterEulerDensityMatrix
open BookProof.ChapterEulerGenericDensity
open BookProof.FullQuadratic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.clockPsi_eq_exp (t : ℝ) :
    (NormedSpace.exp (t • Jgen)).mulVec ![1, 0] = clockPsi t := by sorry
