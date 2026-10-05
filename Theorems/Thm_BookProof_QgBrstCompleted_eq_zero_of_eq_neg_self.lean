-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.eq_zero_of_eq_neg_self
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

theorem BookProof.QgBrstCompleted.eq_zero_of_eq_neg_self {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] {x : E}
    (h : x = -x) : x = 0 := by sorry
