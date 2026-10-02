-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.mFun_add
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_add
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (X Y : Vel → ℂ) :
    mFun i (X + Y) = mFun i X + mFun i Y := by

  funext δ; simp only [mFun, cFun_add, aFun_add, Pi.add_apply, Pi.sub_apply, Pi.smul_apply,
    smul_eq_mul]; ring
