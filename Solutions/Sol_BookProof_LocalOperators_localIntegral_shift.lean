-- Generated from ChapterLocalOperators.lean — solution of BookProof.LocalOperators.localIntegral_shift
import Mathlib
import Definitions.Def_ChapterLocalOperators
import Theorems.Thm_BookProof_LocalOperators_localIntegral_translation_invariant
open BookProof.LocalOperators




open MeasureTheory

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (l : LocalField d E) (y : Fin d → ℝ) :
    localIntegral (fun x => l (x + y)) = localIntegral l := localIntegral_translation_invariant l y
