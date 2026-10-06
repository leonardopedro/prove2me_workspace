-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.bandSignal_sample
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.bandSignal_sample (F : AddCircle T → ℂ) (n : ℤ) :
    bandSignal (T := T) F (-(n / T)) = (T : ℂ) * fourierCoeff F n := by sorry
