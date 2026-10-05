-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgPhase_zero
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Definitions.Def_ChapterFockOneParticleGap
open BookProof.FockOneParticleGap
open BookProof.QgBrstCompleted

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

theorem BookProof.QgBrstCompleted.qgPhase_zero (omega : ℕ → ℝ) (f : QGH) : qgPhase omega 0 f = f := by sorry
