-- Generated from ChapterSirkRestart.lean — solution of BookProof.ChapterSirkRestart.restart_error_accumulation_sirk
import Mathlib
import Definitions.Def_ChapterSirkRestart
import Theorems.Thm_BookProof_ChapterSirkRestart_restart_error_accumulation
open BookProof.ChapterSirkRestart








noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (U S : E →L[ℂ] E) (C Dmin h : ℝ) (m : ℕ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ sirkBound C Dmin h 1 m * ‖w‖)
    (n : ℕ) (v : E) :
    ‖(U ^ n) v - (S ^ n) v‖ ≤ n * sirkBound C Dmin h 1 m * ‖v‖ := restart_error_accumulation U S _ hU hS hstep n v
