-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.brstTerm_anticomm
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QuantumGravityFock_jw_swap_erase
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) {a b : ℕ}
    (hab : a ≠ b) (f : QGH) :
    brstTerm sym hsym a (brstTerm sym hsym b f) + brstTerm sym hsym b (brstTerm sym hsym a f)
      = 0 := by

  ext p
  obtain ⟨n, α⟩ := p
  simp only [lp.coeFn_add, lp.coeFn_zero, Pi.add_apply, Pi.zero_apply, brstTerm_apply]
  by_cases ha : a ∈ α
  · by_cases hb : b ∈ α
    · have hbe : b ∈ α.erase a := Finset.mem_erase.mpr ⟨(Ne.symm hab), hb⟩
      have hae : a ∈ α.erase b := Finset.mem_erase.mpr ⟨hab, ha⟩
      rw [if_pos ha, if_pos hb, if_pos hbe, if_pos hae]
      have hsw : jwSign a α * jwSign b (α.erase a) = -(jwSign b α * jwSign a (α.erase b)) :=
        jw_swap_erase hab ha hb
      have herase : (α.erase a).erase b = (α.erase b).erase a := Finset.erase_right_comm
      rw [herase]
      linear_combination (sym a n * sym b n * f (n, (α.erase b).erase a)) * hsw
    · have hbe : b ∉ α.erase a := fun h => hb (Finset.mem_of_mem_erase h)
      rw [if_pos ha, if_neg hb, if_neg hbe]
      simp
  · by_cases hb : b ∈ α
    · have hae : a ∉ α.erase b := fun h => ha (Finset.mem_of_mem_erase h)
      rw [if_neg ha, if_pos hb, if_neg hae]
      simp
    · rw [if_neg ha, if_neg hb]
      simp
