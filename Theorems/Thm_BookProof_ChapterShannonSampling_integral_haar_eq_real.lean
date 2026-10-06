-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.integral_haar_eq_real
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling

variable {T : ℝ} [hT : Fact (0 < T)]



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.integral_haar_eq_real (g : AddCircle T → ℝ) :
    T * ∫ z : AddCircle T, g z ∂haarAddCircle
      = ∫ ξ in (-(T / 2))..(-(T / 2) + T), g ξ := by sorry
