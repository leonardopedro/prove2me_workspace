-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.pFun_smul
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_smul
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_smul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (a : ℂ) (X : Vel → ℂ) :
    pFun i (a • X) = a • pFun i X := by

  funext δ; simp only [pFun, cFun_smul, aFun_smul, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul]; ring
