-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgPhase_group
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

theorem BookProof.QgBrstCompleted.qgPhase_group (omega : ℕ → ℝ) (s t : ℝ) (f : QGH) :
    qgPhase omega s (qgPhase omega t f) = qgPhase omega (s + t) f := by sorry
