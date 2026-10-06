-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.ops_zero_of_trivial
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Definitions.Def_ChapterDoubleSlit
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterDoubleSlit
open BookProof.ChapterGleasonPureMixed
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}



universe u


theorem BookProof.ChapterWeylSl2.Sl2Rep.ops_zero_of_trivial {W : Submodule ℂ V}
    (hmaps : ∀ v : V, R.E v ∈ W ∧ R.F v ∈ W ∧ R.H v ∈ W)
    (hzero : ∀ x ∈ W, R.E x = 0 ∧ R.F x = 0 ∧ R.H x = 0) (v : V) :
    R.E v = 0 ∧ R.F v = 0 ∧ R.H v = 0 := by sorry
