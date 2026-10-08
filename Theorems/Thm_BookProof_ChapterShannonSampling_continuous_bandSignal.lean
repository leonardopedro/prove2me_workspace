-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.continuous_bandSignal
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.continuous_bandSignal (F : AddCircle T → ℂ)
    (hF : IntegrableOn (fun ξ : ℝ => F ξ) (Ioc (-(T / 2)) (-(T / 2) + T)) volume) :
    Continuous (bandSignal (T := T) F) := by sorry
