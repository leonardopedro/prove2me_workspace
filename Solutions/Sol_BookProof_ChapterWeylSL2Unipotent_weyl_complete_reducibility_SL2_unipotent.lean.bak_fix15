-- Generated from ChapterWeylSL2Unipotent.lean — solution of BookProof.ChapterWeylSL2Unipotent.weyl_complete_reducibility_SL2_unipotent
import Mathlib
import Definitions.Def_ChapterWeylSL2Unipotent
import Theorems.Thm_BookProof_ChapterWeylSL2Unipotent_isExpOfSl2_of_unipotent
import Theorems.Thm_BookProof_ChapterWeylSL2Group_weyl_complete_reducibility_SL2
open BookProof.ChapterWeylSL2Unipotent




open BookProof.ChapterWeylSl2 BookProof.ChapterWeylSL2Group
open Polynomial

universe u

variable {M : Type*} [AddCommGroup M] [Module ℂ M]
variable {V : Type u} [AddCommGroup V] [Module ℂ V]
variable {rho : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V}
  {E F : Module.End ℂ V} {n : ℕ}
variable (hU : ∀ t : ℂ, rho (uPlus t) = expSum E n t)
  (hL : ∀ t : ℂ, rho (uMinus t) = expSum F n t)
variable {N : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V]
    (h : IsUnipotentExp rho E F N) {W : Submodule ℂ V}
    (hW : ∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ v ∈ W, rho g v ∈ W) :
    ∃ U : Submodule ℂ V,
      (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ v ∈ U, rho g v ∈ U) ∧ IsCompl W U := weyl_complete_reducibility_SL2 (isExpOfSl2_of_unipotent h) hW
