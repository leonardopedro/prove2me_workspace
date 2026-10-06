-- Generated from ChapterCoherentTemperature.lean — theorem BookProof.ChapterCoherentTemperature.thermalProb_second_moment
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature

variable {nbar : ℝ}


noncomputable section





theorem BookProof.ChapterCoherentTemperature.thermalProb_second_moment (h : 0 ≤ nbar) :
    ∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n = 2 * nbar ^ 2 + nbar := by sorry
