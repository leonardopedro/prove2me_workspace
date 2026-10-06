-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgBrstTransfer_infDist
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Theorems.Thm_BookProof_QgBrstCompleted_qgPhase_zero
import Theorems.Thm_BookProof_QgBrstCompleted_qgPhase_group
import Theorems.Thm_BookProof_QgBrstCompleted_qgPhase_isometry
import Theorems.Thm_BookProof_BrstReducedTransfer_infDist_exactStates_eq
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})
variable {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (omega : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) (x : QGH) :
    Metric.infDist (qgPhase omega t x) (exactStates (qgBrstCharge sym hsym))
      = Metric.infDist x (exactStates (qgBrstCharge sym hsym)) :=
  infDist_exactStates_eq (qgBrstCharge sym hsym) (qgPhase omega) (qgPhase_commutes hsym omega)
      (qgPhase_zero omega) (qgPhase_group omega) (qgPhase_isometry omega) t x
