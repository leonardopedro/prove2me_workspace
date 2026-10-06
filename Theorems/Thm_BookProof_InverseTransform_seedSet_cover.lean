-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.seedSet_cover
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform

variable {n : ℕ} (p : ℕ → ℝ)



open MeasureTheory Set Function


theorem BookProof.InverseTransform.seedSet_cover (hp : ∀ i, 0 ≤ p i) (hsum : cdf p n = 1) :
    (⋃ k ∈ Finset.range n, seedSet p k) = Set.Ico (0 : ℝ) 1 := by sorry
