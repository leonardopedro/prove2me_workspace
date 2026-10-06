-- Generated from ChapterHowlandAutonomization.lean — theorem BookProof.Howland.isPropagator_of_group
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]



open MeasureTheory

theorem BookProof.Howland.isPropagator_of_group (V : ℝ → H → H) (hzero : ∀ x, V 0 x = x)
    (hadd : ∀ a b x, V a (V b x) = V (a + b) x) (hiso : ∀ a x, ‖V a x‖ = ‖x‖) :
    IsPropagator (fun t s (x : H) => V (t - s) x) where
  refl := by sorry
