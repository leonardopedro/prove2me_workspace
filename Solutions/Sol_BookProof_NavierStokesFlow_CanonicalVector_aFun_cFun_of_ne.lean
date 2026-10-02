-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.aFun_cFun_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_raise_of_ne
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution {i k : Fin 3} (h : i ≠ k) (X : Vel → ℂ) :
    aFun i (cFun k X) = cFun k (aFun i X) := by

  funext β
  simp only [aFun, cFun, raise_of_ne (Ne.symm h), lower_of_ne h,
    lower_raise_of_ne h β]
  ring
