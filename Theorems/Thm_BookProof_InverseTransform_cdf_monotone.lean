-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.cdf_monotone
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform



open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)


theorem BookProof.InverseTransform.cdf_monotone (hp : ∀ i, 0 ≤ p i) : Monotone (cdf p) := by sorry
