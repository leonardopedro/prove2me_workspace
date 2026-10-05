-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.brstTerm_comp_self
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.QgBrstCompleted

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

theorem BookProof.QgBrstCompleted.brstTerm_comp_self {sym : ℕ → BoseConf → ℂ} (hsym : ∀ a n, ‖sym a n‖ ≤ 1) (a : ℕ)
    (f : QGH) : brstTerm sym hsym a (brstTerm sym hsym a f) = 0 := by sorry
