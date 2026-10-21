-- Generated from ChapterHowlandAutonomization.lean — solution of BookProof.Howland.howland_add
import Mathlib
import Definitions.Def_ChapterHowlandAutonomization
open BookProof.Howland




open MeasureTheory

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {H : Type*} [NormedAddCommGroup H]
variable {U : ℝ → ℝ → H → H}

set_option maxHeartbeats 1000000 in
theorem solution (hU : IsPropagator U) (σ τ : ℝ) (ψ : ℝ → H) :
    howland U σ (howland U τ ψ) = howland U (σ + τ) ψ := by

  funext t
  have hsub : t - σ - τ = t - (σ + τ) := by ring
  simp only [howland]
  rw [hU.cocycle, hsub]
