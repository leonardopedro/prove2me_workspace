-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgPhaseFull_not_comm_brst
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

theorem BookProof.QgBrstCompleted.qgPhaseFull_not_comm_brst (omega g : ℕ → ℝ) (hg : g 0 ≠ 0) :
    ¬ ∀ (t : ℝ) (y : QGH), qgPhaseFull omega g t (qgBrstCharge oneSym oneSym_norm_le y)
      = qgBrstCharge oneSym oneSym_norm_le (qgPhaseFull omega g t y) := by sorry
