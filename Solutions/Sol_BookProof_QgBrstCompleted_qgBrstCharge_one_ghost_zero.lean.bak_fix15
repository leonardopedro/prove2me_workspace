-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgBrstCharge_one_ghost_zero
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_oneSym_norm_le
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (f : QGH) (n : BoseConf) :
    (qgBrstCharge oneSym oneSym_norm_le f) (n, ({0} : FermConf)) = f (n, (∅ : FermConf)) := by

  classical
  rw [qgBrstCharge_apply_eq_sum, lp.coeFn_sum, Finset.sum_apply, Finset.sum_eq_single 0]
  · rw [brstTerm_apply]
    have herase : ({0} : FermConf).erase 0 = ∅ := by simp
    rw [if_pos (by simp : (0 : ℕ) ∈ ({0} : FermConf))]
    simp only [herase, oneSym, jwSign, jwCount]
    norm_num
  · intro a _ hane
    rw [brstTerm_apply]
    have ha0 : a ∉ ({0} : FermConf) := by simpa using hane
    simp [ha0]
  · intro h
    exact absurd (Finset.mem_range.mpr (by norm_num [qgGhostModes])) h
