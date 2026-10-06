-- Generated from ChapterWeylSL2Group.lean — theorem BookProof.ChapterWeylSL2Group.weyl_complete_reducibility_SL2
import Mathlib
import Definitions.Def_ChapterWeylSL2Group
import Definitions.Def_ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSl2
open BookProof.ChapterWeylSL2Group

variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V} {R : Sl2Rep V} {N : ℕ}



open BookProof.ChapterWeylSl2

universe u


theorem BookProof.ChapterWeylSL2Group.weyl_complete_reducibility_SL2 [FiniteDimensional ℂ V]
    (h : IsExpOfSl2 rho R N) {W : Submodule ℂ V}
    (hW : ∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ v ∈ W, rho g v ∈ W) :
    ∃ U : Submodule ℂ V,
      (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ v ∈ U, rho g v ∈ U) ∧ IsCompl W U := by sorry
