-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.seedSet_disjoint
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform

variable {n : ℕ} (p : ℕ → ℝ)



open MeasureTheory Set Function


theorem BookProof.InverseTransform.seedSet_disjoint (hp : ∀ i, 0 ≤ p i) :
    Pairwise (Disjoint on seedSet p) := by sorry
