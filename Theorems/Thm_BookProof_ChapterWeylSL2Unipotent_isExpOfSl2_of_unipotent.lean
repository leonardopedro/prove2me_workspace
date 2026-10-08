-- Generated from ChapterWeylSL2Unipotent.lean — theorem BookProof.ChapterWeylSL2Unipotent.isExpOfSl2_of_unipotent
import Definitions.Def_ChapterWeylSl2
import Mathlib
import Definitions.Def_ChapterWeylSL2Unipotent
import Definitions.Def_ChapterWeylSL2Group
open BookProof.ChapterWeylSL2Group
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

theorem BookProof.ChapterWeylSL2Unipotent.isExpOfSl2_of_unipotent (h : IsUnipotentExp rho E F N) :
    IsExpOfSl2 rho (sl2OfUnipotent h) N where
  two_le := by sorry
