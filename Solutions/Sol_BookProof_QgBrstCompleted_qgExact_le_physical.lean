-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgExact_le_physical
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_qgBrstCharge_nilpotent
import Theorems.Thm_BookProof_BookBrstGaugeFixing_exactStates_le_physicalStates
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})
variable {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (omega : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    exactStates (qgBrstCharge sym hsym) ≤ physicalStates (qgBrstCharge sym hsym) := exactStates_le_physicalStates _ (qgBrstCharge_nilpotent hsym)
