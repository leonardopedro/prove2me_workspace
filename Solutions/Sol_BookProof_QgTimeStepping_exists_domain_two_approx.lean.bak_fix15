-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.exists_domain_two_approx
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_ChapterSirkTrotterKato_exists_res_domain_approx
import Theorems.Thm_BookProof_ChapterStoneResolvent_UnboundedSelfAdjoint_op_res
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
theorem solution (v : H) {eps : ℝ} (heps : 0 < eps) :
    ∃ x : T.domain, T.op x ∈ T.domain ∧ ‖v - (x : H)‖ < eps := by

  obtain ⟨w, hw⟩ := exists_res_domain_approx T v heps
  refine ⟨T.res 1 (w : H), ?_, hw⟩
  have h := T.op_res (l := 1) one_ne_zero (w : H)
  rw [h]
  exact T.domain.add_mem w.2 (T.domain.smul_mem _ (T.res 1 (w : H)).2)
