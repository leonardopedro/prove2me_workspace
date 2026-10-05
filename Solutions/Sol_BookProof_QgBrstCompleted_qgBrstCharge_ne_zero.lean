-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgBrstCharge_ne_zero
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_oneSym_norm_le
import Theorems.Thm_BookProof_QgBrstCompleted_qgBrstCharge_one_ghost_zero
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution : qgBrstCharge oneSym oneSym_norm_le ≠ 0 := by

  classical
  intro hzero
  have hval := qgBrstCharge_one_ghost_zero (lp.single 2 ((0 : BoseConf), (∅ : FermConf)) 1) 0
  rw [hzero] at hval
  simp at hval
