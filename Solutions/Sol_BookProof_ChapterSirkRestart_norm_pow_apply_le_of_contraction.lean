-- Generated from ChapterSirkRestart.lean — solution of BookProof.ChapterSirkRestart.norm_pow_apply_le_of_contraction
import Mathlib
import Definitions.Def_ChapterSirkRestart
import Definitions.Def_ChapterH6
open BookProof.ChapterSirkRestart








noncomputable section

open Filter Topology


open BookProof.ChapterH6

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (S : E →L[ℂ] E) (hS : ∀ w : E, ‖S w‖ ≤ ‖w‖)
    (n : ℕ) (v : E) : ‖(S ^ n) v‖ ≤ ‖v‖ := by

  induction n with
  | zero => simp
  | succ n ih =>
    have hstep : ((S ^ (n + 1)) v) = S ((S ^ n) v) := by
      rw [pow_succ']; rfl
    rw [hstep]
    exact le_trans (hS _) ih
