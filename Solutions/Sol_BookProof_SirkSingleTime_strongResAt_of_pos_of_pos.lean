-- Generated from ChapterSirkSingleTimeShift.lean — solution of BookProof.SirkSingleTime.strongResAt_of_pos_of_pos
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Theorems.Thm_BookProof_SirkSingleTime_strongResAt_of_abs_sub_lt
open BookProof.SirkSingleTime









open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}

set_option maxHeartbeats 1000000 in
theorem solution {l m : ℝ} (hl : 0 < l) (hm : 0 < m)
    (h : StrongResAt T S l) : StrongResAt T S m := by

  have hup : ∀ k : ℕ, StrongResAt T S (((3 : ℝ) / 2) ^ k * l) := by
    intro k
    induction k with
    | zero => simpa using h
    | succ k ih =>
        have hpos : 0 < ((3 : ℝ) / 2) ^ k * l := by positivity
        have hstep : StrongResAt T S (((3 : ℝ) / 2) * (((3 : ℝ) / 2) ^ k * l)) := by
          refine strongResAt_of_abs_sub_lt (ne_of_gt hpos) (by positivity) ?_ ih
          have hval : (3 : ℝ) / 2 * (((3 : ℝ) / 2) ^ k * l) - ((3 : ℝ) / 2) ^ k * l
              = (((3 : ℝ) / 2) ^ k * l) / 2 := by ring
          rw [hval, abs_of_pos (by positivity), abs_of_pos hpos]
          linarith
        have hcast : ((3 : ℝ) / 2) * (((3 : ℝ) / 2) ^ k * l) = ((3 : ℝ) / 2) ^ (k + 1) * l := by
          ring
        rwa [hcast] at hstep
  obtain ⟨k, hk⟩ := pow_unbounded_of_one_lt (m / (2 * l)) (by norm_num : (1 : ℝ) < 3 / 2)
  have hL : 0 < ((3 : ℝ) / 2) ^ k * l := by positivity
  have hmlt : m < 2 * (((3 : ℝ) / 2) ^ k * l) := by
    rw [div_lt_iff₀ (by positivity : (0:ℝ) < 2 * l)] at hk
    linarith
  refine strongResAt_of_abs_sub_lt (ne_of_gt hL) (ne_of_gt hm) ?_ (hup k)
  rw [abs_of_pos hL, abs_sub_lt_iff]
  constructor <;> linarith
