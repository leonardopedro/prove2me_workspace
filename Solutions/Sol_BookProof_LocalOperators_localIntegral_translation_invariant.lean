-- Generated from ChapterLocalOperators.lean — solution of BookProof.LocalOperators.localIntegral_translation_invariant
import Mathlib
import Definitions.Def_ChapterLocalOperators
open BookProof.LocalOperators




open MeasureTheory

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (l : LocalField d E) (y : Fin d → ℝ) :
    (∫ x, l (x + y)) = ∫ x, l x := integral_add_right_eq_self l y
