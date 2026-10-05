-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.brstTerm_comp_self
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (a : ℕ)
    (f : QGH) : brstTerm sym hsym a (brstTerm sym hsym a f) = 0 := by

  ext p
  rw [brstTerm_apply]
  by_cases ha : a ∈ p.2
  · rw [if_pos ha, brstTerm_apply, if_neg (Finset.notMem_erase a p.2)]
    simp
  · rw [if_neg ha]
    simp
