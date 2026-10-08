-- Generated from ChapterCoherentTemperature.lean — theorem BookProof.ChapterCoherentTemperature.thermalTemperature_eq_mean_add_half
import Mathlib
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature


noncomputable section




variable {nbar : ℝ}


theorem BookProof.ChapterCoherentTemperature.thermalTemperature_eq_mean_add_half (h : 0 ≤ nbar) :
    thermalTemperature nbar = (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) + 1 / 2 := by sorry
