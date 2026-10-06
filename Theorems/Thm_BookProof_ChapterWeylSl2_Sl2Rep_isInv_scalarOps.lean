-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.isInv_scalarOps
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


theorem BookProof.ChapterWeylSl2.Sl2Rep.isInv_scalarOps {R : Sl2Rep V} {W : Submodule ℂ V} (hW : R.IsInv W) :
    (adRep R).IsInv (scalarOps W) := by sorry
