-- Generated from ChapterQgBrstCompleted.lean — theorem BookProof.QgBrstCompleted.qgBrstCharge_one_ghost_zero
import Definitions.Def_ChapterQuantumGravityFock
import Definitions.Def_ChapterBrstReducedTransfer
import Mathlib
import Definitions.Def_ChapterQgBrstCompleted
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar
open BookProof.QgBrstCompleted



open scoped ENNReal
open BookProof BookProof.QuantumGravityFock BookProof.BrstReducedTransfer

noncomputable section

variable {ι : Type*}
variable (w : ι → ℂ) (e : ι → ι) (hw : ∀ i, ‖w i‖ ≤ 1) (hinj : Set.InjOn e {i | w i ≠ 0})

theorem BookProof.QgBrstCompleted.qgBrstCharge_one_ghost_zero (f : QGH) (n : BoseConf) :
    (qgBrstCharge oneSym oneSym_norm_le f) (n, ({0} : FermConf)) = f (n, (∅ : FermConf)) := by sorry
