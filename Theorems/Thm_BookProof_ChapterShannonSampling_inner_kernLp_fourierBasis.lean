-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.inner_kernLp_fourierBasis
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.inner_kernLp_fourierBasis (x : ℝ) (n : ℤ) :
    inner ℂ (kernLp (T := T) x) (fourierBasis (T := T) n) = (sinc (T * x + n) : ℝ) := by sorry
