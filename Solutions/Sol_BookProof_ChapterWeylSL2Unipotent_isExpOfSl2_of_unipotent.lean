-- Generated from ChapterWeylSL2Unipotent.lean — solution of BookProof.ChapterWeylSL2Unipotent.isExpOfSl2_of_unipotent
import Mathlib
import Definitions.Def_ChapterWeylSL2Unipotent
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
theorem solution (h : IsUnipotentExp rho E F N) :
    IsExpOfSl2 rho (sl2OfUnipotent h) N where
  two_le :=
  where
    two_le := h.two_le
    expE t := h.expE t
    expF t := h.expF t
