-- Generated from ChapterHowlandAutonomization.lean — theorem BookProof.Howland.howland_add
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem
open BookProof.Howland



open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]
variable {U : ℝ → ℝ → H → H}

theorem BookProof.Howland.howland_add (hU : IsPropagator U) (σ τ : ℝ) (ψ : ℝ → H) :
    howland U σ (howland U τ ψ) = howland U (σ + τ) ψ := by sorry
