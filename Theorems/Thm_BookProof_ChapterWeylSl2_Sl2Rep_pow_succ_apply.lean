-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.pow_succ_apply
import Mathlib
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}



universe u


theorem BookProof.ChapterWeylSl2.Sl2Rep.pow_succ_apply (T : Module.End ℂ V) (k : ℕ) (v : V) :
    (T ^ (k + 1)) v = T ((T ^ k) v) := by sorry
