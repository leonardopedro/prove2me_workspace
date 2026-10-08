-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.seedSet_disjoint
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform



open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)


theorem BookProof.InverseTransform.seedSet_disjoint (hp : ∀ i, 0 ≤ p i) :
    Pairwise (Disjoint on seedSet p) := by sorry
