-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.cFun_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_lower_comm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (X : Vel → ℂ) : cFun i (cFun k X) = cFun k (cFun i X) := by

  by_cases hik : i = k
  · rw [hik]
  · funext β
    simp only [cFun, lower_of_ne (Ne.symm hik), lower_of_ne hik, lower_comm i k β]
    ring
