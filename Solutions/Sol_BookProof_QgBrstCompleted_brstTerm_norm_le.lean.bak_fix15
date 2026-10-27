-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.brstTerm_norm_le
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_wshift_norm_le
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (a : ℕ)
    (f : QGH) : ‖brstTerm sym hsym a f‖ ≤ ‖f‖ := wshift_norm_le _ _ _ _ f
