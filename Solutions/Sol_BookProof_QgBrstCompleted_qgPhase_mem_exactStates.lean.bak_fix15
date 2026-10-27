-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgPhase_mem_exactStates
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})
variable {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (omega : ℕ → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) {x : QGH}
    (hx : x ∈ exactStates (qgBrstCharge sym hsym)) :
    qgPhase omega t x ∈ exactStates (qgBrstCharge sym hsym) := exactStates_invariant (Om := qgBrstCharge sym hsym) (qgPhase_commutes hsym omega t) x hx
