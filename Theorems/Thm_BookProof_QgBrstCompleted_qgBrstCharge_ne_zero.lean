-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgBrstCharge_ne_zero
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
open BookProof.QgBrstCompleted



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

theorem BookProof.QgBrstCompleted.qgBrstCharge_ne_zero : qgBrstCharge oneSym oneSym_norm_le ≠ 0 := by sorry
