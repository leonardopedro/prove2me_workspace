-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.bandSignal_eq_circle_integral
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.bandSignal_eq_circle_integral (F : AddCircle T → ℂ) (x : ℝ) :
    bandSignal (T := T) F x = ∫ z : AddCircle T, conj (kern (T := T) x z) * F z := by sorry
