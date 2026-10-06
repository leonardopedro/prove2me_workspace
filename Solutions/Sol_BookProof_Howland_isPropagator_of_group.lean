-- Generated from ChapterHowlandAutonomization.lean — solution of BookProof.Howland.isPropagator_of_group
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland




open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → H → H) (hzero : ∀ x, V 0 x = x)
    (hadd : ∀ a b x, V a (V b x) = V (a + b) x) (hiso : ∀ a x, ‖V a x‖ = ‖x‖) :
    IsPropagator (fun t s (x : H) => V (t - s) x) where
  refl :=
  where
    refl := by intro t x; simpa using hzero x
    cocycle := by
      intro t s r x
      have : t - s + (s - r) = t - r := by ring
      rw [hadd, this]
    isometry := by intro t s x; exact hiso _ x
