-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.eq_zero_of_eq_neg_self
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] {x : E}
    (h : x = -x) : x = 0 := by

  have h2 : (2 : ℂ) • x = 0 := by
    rw [two_smul]
    nth_rewrite 2 [h]
    simp
  simpa using h2
