-- Generated from ChapterCoherentTemperature.lean — theorem BookProof.ChapterCoherentTemperature.thermalProb_variance
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature

variable {nbar : ℝ}


noncomputable section





theorem BookProof.ChapterCoherentTemperature.thermalProb_variance (h : 0 ≤ nbar) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n)
      - (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) ^ 2 = nbar ^ 2 + nbar := by sorry
