-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.integral_haar_eq
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

variable {T : ℝ} [hT : Fact (0 < T)]

theorem BookProof.ChapterShannonSampling.integral_haar_eq (g : AddCircle T → ℂ) :
    (T : ℂ) * ∫ z : AddCircle T, g z ∂haarAddCircle
      = ∫ ξ in (-(T / 2))..(-(T / 2) + T), g ξ := by sorry
