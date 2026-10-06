-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgBrstTransfer_comp
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_qgPhase_group
import Theorems.Thm_BookProof_BrstReducedTransfer_transfer_comp
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})
variable {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (omega : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) :
    (qgBrstTransfer hsym omega s).comp (qgBrstTransfer hsym omega t)
      = qgBrstTransfer hsym omega (s + t) :=
  transfer_comp (qgBrstCharge sym hsym) (qgPhase omega) (qgPhase_commutes hsym omega)
      (qgPhase_group omega) s t
