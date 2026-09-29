-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_band_contained
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_band_contained (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) (n : ℕ) :
    Set.Icc (0 : ℝ) (sirkBound C Dmin h nv (n + 1))
      ⊆ Set.Icc (0 : ℝ) (sirkBound C Dmin h nv n) := by sorry
