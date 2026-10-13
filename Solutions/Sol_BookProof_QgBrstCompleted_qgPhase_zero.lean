-- Generated from ChapterQgBrstCompleted.lean — solution of BookProof.QgBrstCompleted.qgPhase_zero
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.QgBrstCompleted




open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer
open BookProof.FockOneParticleGap

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

set_option maxHeartbeats 1000000 in
theorem solution (omega : ℕ → ℝ) (f : QGH) : qgPhase omega 0 f = f := by

  ext p
  simp [phaseWeight]
