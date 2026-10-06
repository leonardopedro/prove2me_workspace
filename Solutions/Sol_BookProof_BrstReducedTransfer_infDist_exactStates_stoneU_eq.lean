-- Generated from ChapterBrstReducedTransfer.lean — solution of BookProof.BrstReducedTransfer.infDist_exactStates_stoneU_eq
import Mathlib
import Definitions.Def_ChapterBrstReducedTransfer
import Theorems.Thm_BookProof_BrstReducedTransfer_infDist_exactStates_eq
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_norm_stoneU_apply
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_apply_stoneU
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_stoneU_zero
open BookProof.BrstReducedTransfer




open BookProof BookProof.ChapterStoneResolvent


variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]
variable (Om : H →L[ℂ] H)
variable {Om}
variable (Om)
variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) (Om : H →L[ℂ] H)
variable (hcomm : ∀ (t : ℝ) (y : H), T.stoneU t (Om y) = Om (T.stoneU t y))

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (x : H) :
    Metric.infDist (T.stoneU t x) (exactStates Om) = Metric.infDist x (exactStates Om) :=
  infDist_exactStates_eq Om _ hcomm (by simp) (fun s t x => T.stoneU_apply_stoneU s t x)
      (fun s y => T.norm_stoneU_apply s y) t x
