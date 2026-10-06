-- Generated from ChapterHowlandAutonomization.lean — theorem BookProof.Howland.howland_lintegral_normSq
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]
variable {U : ℝ → ℝ → H → H}



open MeasureTheory

theorem BookProof.Howland.howland_lintegral_normSq (hU : IsPropagator U) (σ : ℝ) (ψ : ℝ → H) :
    ∫⁻ t, ENNReal.ofReal (‖howland U σ ψ t‖ ^ 2)
      = ∫⁻ t, ENNReal.ofReal (‖ψ t‖ ^ 2) := by sorry
