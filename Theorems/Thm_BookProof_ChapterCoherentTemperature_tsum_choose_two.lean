-- Generated from ChapterCoherentTemperature.lean — theorem BookProof.ChapterCoherentTemperature.tsum_choose_two
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature

variable {nbar : ℝ}


noncomputable section





theorem BookProof.ChapterCoherentTemperature.tsum_choose_two (h : 0 ≤ nbar) :
    ∑' n : ℕ, ((n + 2).choose 2 : ℝ) * thermalRatio nbar ^ n
      = 1 / (1 - thermalRatio nbar) ^ 3 := by sorry
