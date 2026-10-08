-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.bandSignal_sample
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.bandSignal_sample (F : AddCircle T → ℂ) (n : ℤ) :
    bandSignal (T := T) F (-(n / T)) = (T : ℂ) * fourierCoeff F n := by sorry
