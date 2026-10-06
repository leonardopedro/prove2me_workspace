-- Generated from ChapterProbabilityClockStochastic.lean — theorem BookProof.ProbabilityClockStochastic.rotMat_mulVec_clockPsi
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
import Definitions.Def_ChapterEulerDensityMatrix
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.ChapterEulerDensityMatrix
open BookProof.FullQuadratic
open BookProof.ProbabilityClockStochastic



open Matrix
open scoped Norms.Operator

theorem BookProof.ProbabilityClockStochastic.rotMat_mulVec_clockPsi (t a : ℝ) :
    (rotMat a).mulVec (clockPsi t) = clockPsi (t + a) := by sorry
