-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.seedSet_total_measure
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform

variable {n : ℕ} (p : ℕ → ℝ)



open MeasureTheory Set Function


theorem BookProof.InverseTransform.seedSet_total_measure (hp : ∀ i, 0 ≤ p i) (hsum : cdf p n = 1) :
    ∑ k ∈ Finset.range n, volume (seedSet p k) = 1 := by sorry
