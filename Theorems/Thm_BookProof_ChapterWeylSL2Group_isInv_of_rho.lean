-- Generated from ChapterWeylSL2Group.lean — theorem BookProof.ChapterWeylSL2Group.isInv_of_rho
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
import Definitions.Def_ChapterDoubleSlit
import Definitions.Def_ChapterGleasonPureMixed
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterDoubleSlit
open BookProof.ChapterGleasonPureMixed
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSL2Group



open BookProof.ChapterWeylSl2

universe u

variable {V : Type u} [AddCommGroup V] [Module ℂ V]

variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}

theorem BookProof.ChapterWeylSL2Group.isInv_of_rho (h : IsExpOfSl2 rho R N) {W : Submodule ℂ V}
    (hplus : ∀ (t : ℂ), ∀ v ∈ W, rho (uPlus t) v ∈ W)
    (hminus : ∀ (t : ℂ), ∀ v ∈ W, rho (uMinus t) v ∈ W) : R.IsInv W := by sorry
