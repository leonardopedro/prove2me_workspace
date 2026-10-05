-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgPhase_single
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterYangMillsGhostSector
open BookProof.FockOneParticleGap
open BookProof.YangMillsGhost
open BookProof.QgBrstCompleted

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

theorem BookProof.QgBrstCompleted.qgPhase_single (omega : ℕ → ℝ) (t : ℝ) (p : GradedIdx) (c : ℂ) :
    qgPhase omega t (lp.single 2 p c)
      = Complex.exp (-(t * qgGradedSymbol omega (fun _ => 0) p) * Complex.I) •
          lp.single 2 p c := by sorry
