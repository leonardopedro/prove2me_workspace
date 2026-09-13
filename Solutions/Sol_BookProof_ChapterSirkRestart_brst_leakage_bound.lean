-- Generated from ChapterSirkRestart.lean — solution of BookProof.ChapterSirkRestart.brst_leakage_bound
import Mathlib
import Definitions.Def_ChapterSirkRestart
import Theorems.Thm_BookProof_ChapterSirkRestart_restart_error_accumulation
import Theorems.Thm_BookProof_ChapterSirkRestart_brst_leakage_zero_of_exact
import Definitions.Def_ChapterH6
open BookProof.ChapterSirkRestart








noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (U S Om : E →L[ℂ] E) (eps : ℝ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ eps * ‖w‖)
    (hcomm : Om.comp U = U.comp Om)
    (n : ℕ) (v : E) (hv : Om v = 0) :
    ‖Om ((S ^ n) v)‖ ≤ ‖Om‖ * (n * eps * ‖v‖) := by

  have hexact : Om ((U ^ n) v) = 0 := brst_leakage_zero_of_exact U Om hcomm n v hv
  have hsplit : Om ((S ^ n) v) = -(Om ((U ^ n) v - (S ^ n) v)) := by
    rw [map_sub, hexact]
    abel
  rw [hsplit, norm_neg]
  refine le_trans (Om.le_opNorm _) ?_
  exact mul_le_mul_of_nonneg_left
    (restart_error_accumulation U S eps hU hS hstep n v) (norm_nonneg _)
