-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.substrateInterval_subset
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : substrateInterval n ⊆ Icc (0 : ℝ) 1 := by

  intro x hx
  obtain ⟨h1, h2⟩ := hx
  have hn1 : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hn2 : (0 : ℝ) < (n : ℝ) + 2 := by positivity
  constructor
  · have : (0 : ℝ) < 1 / ((n : ℝ) + 2) := by positivity
    linarith
  · have : 1 / ((n : ℝ) + 1) ≤ 1 := by
      rw [div_le_one hn1]; linarith [Nat.cast_nonneg (α := ℝ) n]
    linarith
