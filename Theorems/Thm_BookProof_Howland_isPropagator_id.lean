-- Generated from ChapterHowlandAutonomization.lean — theorem BookProof.Howland.isPropagator_id
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland



open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]

theorem BookProof.Howland.isPropagator_id : IsPropagator (fun (_ _ : ℝ) (x : H) => x) where
  refl := by sorry
