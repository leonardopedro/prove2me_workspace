-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.sirk_bands_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.sirk_bands_tendsto_zero (C Dmin h nv : ℝ) (hh : 0 < h) :
    Filter.Tendsto (fun n : ℕ => sirkBound C Dmin h nv n) Filter.atTop (nhds 0) := by sorry
