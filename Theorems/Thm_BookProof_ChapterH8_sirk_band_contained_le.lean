-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_band_contained_le
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_band_contained_le (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) {m n : ℕ} (hmn : m ≤ n) :
    Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n)
      ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv m) := by sorry
