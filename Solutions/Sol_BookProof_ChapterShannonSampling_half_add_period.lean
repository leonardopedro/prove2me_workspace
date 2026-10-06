-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.half_add_period
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

set_option maxHeartbeats 1000000 in
omit hT in
theorem solution : -(T / 2) + T = T / 2 := by
 ring
