-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_iterate_cnStep_sub_stoneU_le
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_norm_cnStep_apply
import Theorems.Thm_BookProof_QgTimeStepping_norm_cnStep_sub_stoneU_le
import Theorems.Thm_BookProof_QgTimeStepping_stoneU_mem_domain_two
import Theorems.Thm_BookProof_QgTimeStepping_norm_op_two_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_mem_domain
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
open BookProof.QgTimeStepping




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL BookProof.QgTruncationResolvent

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution {tau : ℝ} (htau : 0 < tau) (k : ℕ) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖(cnStep T tau)^[k] (x : H) - T.stoneU ((k : ℝ) * tau) (x : H)‖
      ≤ 2 * (k : ℝ) * tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by

  induction k with
  | zero => simp
  | succ k ih =>
      set x2 : T.domain := ⟨T.op x, hx⟩ with hx2
      set y : T.domain := ⟨T.stoneU ((k : ℝ) * tau) (x : H),
        T.stoneU_mem_domain ((k : ℝ) * tau) x⟩ with hy
      have hymem : T.op y ∈ T.domain := stoneU_mem_domain_two T ((k : ℝ) * tau) x hx
      have hynorm : ‖T.op ⟨T.op y, hymem⟩‖ = ‖T.op x2‖ :=
        norm_op_two_stoneU T ((k : ℝ) * tau) x hx
      have hstep1 : ‖cnStep T tau ((cnStep T tau)^[k] (x : H)) - cnStep T tau ((y : H))‖
          ≤ 2 * (k : ℝ) * tau ^ 2 * ‖T.op x2‖ := by
        rw [← map_sub, norm_cnStep_apply T (ne_of_gt htau)]
        exact ih
      have hstep2 : ‖cnStep T tau ((y : H)) - T.stoneU tau ((y : H))‖
          ≤ 2 * tau ^ 2 * ‖T.op x2‖ := by
        have := norm_cnStep_sub_stoneU_le T htau y hymem
        rwa [hynorm] at this
      have hflow : T.stoneU tau ((y : H)) = T.stoneU (((k : ℝ) + 1) * tau) (x : H) := by
        change T.stoneU tau (T.stoneU ((k : ℝ) * tau) (x : H)) = _
        rw [T.stoneU_apply_stoneU]
        ring_nf
      have hsplit : (cnStep T tau)^[k + 1] (x : H)
            - T.stoneU (((k : ℕ) + 1 : ℝ) * tau) (x : H)
          = (cnStep T tau ((cnStep T tau)^[k] (x : H)) - cnStep T tau ((y : H)))
            + (cnStep T tau ((y : H)) - T.stoneU tau ((y : H))) := by
        rw [Function.iterate_succ_apply', hflow]
        abel
      have hcast : ((k + 1 : ℕ) : ℝ) = (k : ℝ) + 1 := by push_cast; ring
      rw [hcast, hsplit]
      have := norm_add_le (cnStep T tau ((cnStep T tau)^[k] (x : H)) - cnStep T tau ((y : H)))
        (cnStep T tau ((y : H)) - T.stoneU tau ((y : H)))
      have hnn : (0 : ℝ) ≤ ‖T.op x2‖ := norm_nonneg _
      nlinarith
