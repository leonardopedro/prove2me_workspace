-- Generated from ChapterHowlandAutonomization.lean — theorem BookProof.Howland.howland_neg
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]
variable {U : ℝ → ℝ → H → H}



open MeasureTheory

theorem BookProof.Howland.howland_neg (hU : IsPropagator U) (σ : ℝ) (ψ : ℝ → H) :
    howland U (-σ) (howland U σ ψ) = ψ := by sorry
