-- Generated from ChapterLocalOperators.lean — theorem BookProof.LocalOperators.localIntegral_shift
import Mathlib
import Definitions.Def_ChapterLocalOperators
open BookProof.LocalOperators

variable {d : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]



open MeasureTheory


theorem BookProof.LocalOperators.localIntegral_shift (l : LocalField d E) (y : Fin d → ℝ) :
    localIntegral (fun x => l (x + y)) = localIntegral l := by sorry
