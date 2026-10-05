-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.oneSym_norm_le
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (a : ℕ) (n : BoseConf) : ‖oneSym a n‖ ≤ 1 := by
 simp [oneSym]
