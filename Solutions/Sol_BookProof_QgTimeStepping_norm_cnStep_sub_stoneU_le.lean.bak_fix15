-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_cnStep_sub_stoneU_le
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_norm_cnStep_sub_taylor_le
import Theorems.Thm_BookProof_QgTimeStepping_norm_stoneU_sub_taylor_le
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
theorem solution {tau : ℝ} (htau : 0 < tau) (x : T.domain)
    (hx : T.op x ∈ T.domain) :
    ‖cnStep T tau (x : H) - T.stoneU tau (x : H)‖ ≤ 2 * tau ^ 2 * ‖T.op ⟨T.op x, hx⟩‖ := by

  have h1 := norm_cnStep_sub_taylor_le T htau x hx
  have h2 := norm_stoneU_sub_taylor_le T (le_of_lt htau) x hx
  have hsplit : cnStep T tau (x : H) - T.stoneU tau (x : H)
      = (cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x))
        - (T.stoneU tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x)) := by
    abel
  rw [hsplit]
  have := norm_sub_le (cnStep T tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x))
    (T.stoneU tau (x : H) - ((x : H) - ((tau : ℂ) * Complex.I) • T.op x))
  have hnn : (0 : ℝ) ≤ ‖T.op ⟨T.op x, hx⟩‖ := norm_nonneg _
  nlinarith
