-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.cas_apply_eq
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


theorem BookProof.ChapterWeylSl2.Sl2Rep.cas_apply_eq {R : Sl2Rep V} (v : V) :
    R.cas v = 2 • (R.E (R.F v) + R.F (R.E v)) + R.H (R.H v) := by sorry
