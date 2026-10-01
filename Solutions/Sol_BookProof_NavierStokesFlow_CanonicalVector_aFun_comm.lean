-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.aFun_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_raise_comm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (X : Vel → ℂ) : aFun i (aFun k X) = aFun k (aFun i X) := by

  by_cases hik : i = k
  · rw [hik]
  · funext β
    simp only [aFun, raise_of_ne (Ne.symm hik), raise_of_ne hik, raise_comm i k β]
    ring
