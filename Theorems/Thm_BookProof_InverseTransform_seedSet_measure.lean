-- Generated from ChapterInverseTransform.lean — theorem BookProof.InverseTransform.seedSet_measure
import Mathlib
import Definitions.Def_ChapterInverseTransform
open BookProof.InverseTransform

variable {n : ℕ} (p : ℕ → ℝ)



open MeasureTheory Set Function


theorem BookProof.InverseTransform.seedSet_measure (k : ℕ) :
    volume (seedSet p k) = ENNReal.ofReal (p k) := by sorry
