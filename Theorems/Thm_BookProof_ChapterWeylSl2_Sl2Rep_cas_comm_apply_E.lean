-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.cas_comm_apply_E
import Mathlib
import Definitions.Def_ChapterWeylSl2
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2



universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable (R : Sl2Rep V)
variable {R}
variable {R : Sl2Rep V}

theorem BookProof.ChapterWeylSl2.Sl2Rep.cas_comm_apply_E (v : V) : R.cas (R.E v) = R.E (R.cas v) := by sorry
