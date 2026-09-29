-- Generated from ChapterSirkRestart.lean — solution of BookProof.ChapterSirkRestart.restart_error_tendsto_zero
import Mathlib
import Definitions.Def_ChapterSirkRestart
import Theorems.Thm_BookProof_ChapterH6_sirk_error_decay_exponential
import Definitions.Def_ChapterH6
open BookProof.ChapterSirkRestart








noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (C Dmin h nv : ℝ) (n : ℕ) (hh : 0 < h) :
    Tendsto (fun m : ℕ => (n : ℝ) * sirkBound C Dmin h nv m) atTop (𝓝 0) := by

  have := (sirk_error_decay_exponential C Dmin h nv hh).const_mul (n : ℝ)
  simpa using this
