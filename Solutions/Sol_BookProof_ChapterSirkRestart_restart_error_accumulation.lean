-- Generated from ChapterSirkRestart.lean — solution of BookProof.ChapterSirkRestart.restart_error_accumulation
import Mathlib
import Definitions.Def_ChapterSirkRestart
import Theorems.Thm_BookProof_ChapterSirkRestart_norm_pow_apply_le_of_contraction
open BookProof.ChapterSirkRestart








noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (U S : E →L[ℂ] E) (eps : ℝ)
    (hU : ∀ w : E, ‖U w‖ ≤ ‖w‖) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (hstep : ∀ w : E, ‖U w - S w‖ ≤ eps * ‖w‖)
    (n : ℕ) (v : E) :
    ‖(U ^ n) v - (S ^ n) v‖ ≤ n * eps * ‖v‖ := by

  rcases eq_or_ne v 0 with rfl | hv0
  · simp
  have hvpos : 0 < ‖v‖ := norm_pos_iff.mpr hv0
  have heps : 0 ≤ eps := by
    have h0 : (0 : ℝ) ≤ eps * ‖v‖ := le_trans (norm_nonneg _) (hstep v)
    nlinarith
  induction n with
  | zero => simp
  | succ n ih =>
    have hUstep : ((U ^ (n + 1)) v) = U ((U ^ n) v) := by rw [pow_succ']; rfl
    have hSstep : ((S ^ (n + 1)) v) = S ((S ^ n) v) := by rw [pow_succ']; rfl
    have hsplit : U ((U ^ n) v) - S ((S ^ n) v)
        = U ((U ^ n) v - (S ^ n) v) + (U ((S ^ n) v) - S ((S ^ n) v)) := by
      rw [map_sub]; abel
    have h1 : ‖U ((U ^ n) v - (S ^ n) v)‖ ≤ n * eps * ‖v‖ :=
      le_trans (hU _) ih
    have h2 : ‖U ((S ^ n) v) - S ((S ^ n) v)‖ ≤ eps * ‖v‖ := by
      refine le_trans (hstep _) ?_
      exact mul_le_mul_of_nonneg_left
        (norm_pow_apply_le_of_contraction S hS n v) heps
    rw [hUstep, hSstep, hsplit]
    refine le_trans (norm_add_le _ _) ?_
    have : ((n : ℝ) + 1) * eps * ‖v‖ = n * eps * ‖v‖ + eps * ‖v‖ := by ring
    push_cast
    linarith
