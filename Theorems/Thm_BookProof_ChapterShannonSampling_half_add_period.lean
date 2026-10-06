-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.half_add_period
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

omit hT in
theorem BookProof.ChapterShannonSampling.half_add_period : -(T / 2) + T = T / 2 := by sorry
