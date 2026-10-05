-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgPhase_group
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (omega : ℕ → ℝ) (s t : ℝ) (f : QGH) :
    qgPhase omega s (qgPhase omega t f) = qgPhase omega (s + t) f := by

  ext p
  simp only [qgPhase_apply, phaseWeight, ← mul_assoc, ← Complex.exp_add]
  congr 2
  push_cast
  ring
