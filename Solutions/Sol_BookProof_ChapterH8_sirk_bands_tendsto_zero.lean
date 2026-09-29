-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.sirk_bands_tendsto_zero
import Mathlib
import Definitions.Def_ChapterH8
import Theorems.Thm_BookProof_ChapterH6_sirk_error_decay_exponential
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (C Dmin h nv : ℝ) (hh : 0 < h) :
    Filter.Tendsto (fun n : ℕ => sirkBound C Dmin h nv n) Filter.atTop (nhds 0) := sirk_error_decay_exponential C Dmin h nv hh
