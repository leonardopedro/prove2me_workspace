-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.seedSet_measure
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform



open MeasureTheory Set Function

variable {n : ℕ} (p : ℕ → ℝ)


theorem BookProof.InverseTransform.seedSet_measure (k : ℕ) :
    volume (seedSet p k) = ENNReal.ofReal (p k) := by sorry
