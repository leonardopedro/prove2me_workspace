-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgExact_le_physical
import Definitions.Def_ChapterQuantumGravityFock
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Definitions.Def_ChapterBrstReducedTransfer
open BookProof.BrstReducedTransfer
open BookProof.QgBrstCompleted

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})
variable {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (omega : ℕ → ℝ)



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

theorem BookProof.QgBrstCompleted.qgExact_le_physical :
    exactStates (qgBrstCharge sym hsym) ≤ physicalStates (qgBrstCharge sym hsym) := by sorry
