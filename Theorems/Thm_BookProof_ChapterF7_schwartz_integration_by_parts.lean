-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.schwartz_integration_by_parts
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.schwartz_integration_by_parts (f g : 𝓢(ℝ, ℂ)) :
    (∫ x, (starRingEnd ℂ) (deriv (f : ℝ → ℂ) x) * g x)
      = - ∫ x, (starRingEnd ℂ) (f x) * deriv (g : ℝ → ℂ) x := by sorry
