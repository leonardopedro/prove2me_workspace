-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.cdf_monotone
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform

variable {n : ℕ} (p : ℕ → ℝ)



open MeasureTheory Set Function


theorem BookProof.InverseTransform.cdf_monotone (hp : ∀ i, 0 ≤ p i) : Monotone (cdf p) := by sorry
