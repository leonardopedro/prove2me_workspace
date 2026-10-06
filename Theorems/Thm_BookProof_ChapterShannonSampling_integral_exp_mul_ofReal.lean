-- Generated from ChapterShannonSampling.lean — theorem BookProof.ChapterShannonSampling.integral_exp_mul_ofReal
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling



open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

theorem BookProof.ChapterShannonSampling.integral_exp_mul_ofReal (T a : ℝ) (hT : 0 < T) :
    (∫ ξ in (-(T / 2))..(T / 2), Complex.exp (2 * π * I * a * ξ))
      = (T : ℂ) * (sinc (a * T) : ℝ) := by sorry
