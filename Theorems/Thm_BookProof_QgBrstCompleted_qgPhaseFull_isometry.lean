-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgPhaseFull_isometry
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

theorem BookProof.QgBrstCompleted.qgPhaseFull_isometry (omega g : ℕ → ℝ) (t : ℝ) (f : QGH) :
    ‖qgPhaseFull omega g t f‖ = ‖f‖ := by sorry
