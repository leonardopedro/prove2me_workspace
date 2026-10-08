-- Generated from ChapterLocalOperators.lean — theorem BookProof.LocalOperators.localIntegral_translation_invariant
import Mathlib
import Definitions.Def_ChapterLocalOperators
open BookProof.LocalOperators



open MeasureTheory

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.LocalOperators.localIntegral_translation_invariant (l : LocalField d E) (y : Fin d → ℝ) :
    (∫ x, l (x + y)) = ∫ x, l x := by sorry
