-- Generated from ChapterHowlandAutonomization.lean — solution of BookProof.Howland.howland_neg
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
import Theorems.Thm_BookProof_Howland_howland_add
open BookProof.Howland




open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]
variable {U : ℝ → ℝ → H → H}

set_option maxHeartbeats 1000000 in
theorem solution (hU : IsPropagator U) (σ : ℝ) (ψ : ℝ → H) :
    howland U (-σ) (howland U σ ψ) = ψ := by

  rw [howland_add hU, neg_add_cancel, howland_zero hU]
