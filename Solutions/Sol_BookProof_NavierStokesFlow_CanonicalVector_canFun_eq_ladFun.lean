-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canFun_eq_ladFun
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_comm
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_comm
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_cFun_of_ne
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_symProdFun_eq
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canFun_eq_sum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- Both sides expand into the same several-dozen-term ladder polynomial; normalising it
-- with `ring` exceeds the default heartbeat budget.
theorem solution (X : Vel → ℂ) (γ : Vel) :
    canFun A c X γ = ladFun A c X γ := by

  rw [canFun_eq_sum]
  simp +decide only [ladFun, mFun, symProdFun_eq, Fin.sum_univ_three,
    Pi.sub_apply, Pi.smul_apply, smul_eq_mul, coefPair, coefRot,
    aFun_cFun_of_ne (show (0 : Fin 3) ≠ 1 by decide),
    aFun_cFun_of_ne (show (0 : Fin 3) ≠ 2 by decide),
    aFun_cFun_of_ne (show (1 : Fin 3) ≠ 0 by decide),
    aFun_cFun_of_ne (show (1 : Fin 3) ≠ 2 by decide),
    aFun_cFun_of_ne (show (2 : Fin 3) ≠ 0 by decide),
    aFun_cFun_of_ne (show (2 : Fin 3) ≠ 1 by decide),
    cFun_comm 1 0, cFun_comm 2 0, cFun_comm 2 1,
    aFun_comm 1 0, aFun_comm 2 0, aFun_comm 2 1]
  push_cast
  ring
