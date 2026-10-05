-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgBrstCharge_nilpotent
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_brstTerm_comp_self
import Theorems.Thm_BookProof_QgBrstCompleted_brstTerm_anticomm
import Theorems.Thm_BookProof_QgBrstCompleted_eq_zero_of_eq_neg_self
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1)
    (f : QGH) : qgBrstCharge sym hsym (qgBrstCharge sym hsym f) = 0 := by

  classical
  have hanti : ∀ a b : ℕ, brstTerm sym hsym a (brstTerm sym hsym b f)
      + brstTerm sym hsym b (brstTerm sym hsym a f) = 0 := by
    intro a b
    by_cases hab : a = b
    · subst hab
      simp [brstTerm_comp_self hsym a f]
    · exact brstTerm_anticomm hsym hab f
  have hS : qgBrstCharge sym hsym (qgBrstCharge sym hsym f)
      = ∑ a ∈ Finset.range qgGhostModes, ∑ b ∈ Finset.range qgGhostModes,
          brstTerm sym hsym a (brstTerm sym hsym b f) := by
    rw [qgBrstCharge_apply_eq_sum, qgBrstCharge_apply_eq_sum]
    exact Finset.sum_congr rfl fun a _ => map_sum _ _ _
  rw [hS]
  refine eq_zero_of_eq_neg_self ?_
  calc ∑ a ∈ Finset.range qgGhostModes, ∑ b ∈ Finset.range qgGhostModes,
          brstTerm sym hsym a (brstTerm sym hsym b f)
      = ∑ a ∈ Finset.range qgGhostModes, ∑ b ∈ Finset.range qgGhostModes,
          -brstTerm sym hsym a (brstTerm sym hsym b f) := by
        rw [Finset.sum_comm]
        exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          eq_neg_of_add_eq_zero_left (hanti b a)
    _ = -∑ a ∈ Finset.range qgGhostModes, ∑ b ∈ Finset.range qgGhostModes,
          brstTerm sym hsym a (brstTerm sym hsym b f) := by
        simp
