-- Generated from ChapterWeylSl2.lean — theorem BookProof.ChapterWeylSl2.Sl2Rep.highestWeight_nat
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


theorem BookProof.ChapterWeylSl2.Sl2Rep.highestWeight_nat [FiniteDimensional ℂ V] {R : Sl2Rep V} {w : V} {lam : ℂ}
    (hw : w ≠ 0) (hE : R.E w = 0) (h : R.H w = lam • w) :
    ∃ m : ℕ, lam = (m : ℂ) ∧ (R.F ^ (m + 1)) w = 0 := by sorry
