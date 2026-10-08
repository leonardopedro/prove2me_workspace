-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.symProdFun_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_inv_sqrt_two_sq
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_smul
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_sub
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_smul
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_sub
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) (X : Vel → ℂ) (γ : Vel) :
    symProdFun i k X γ
      = (Complex.I / 4) * (cFun i (cFun k X) γ + cFun i (aFun k X) γ
          - aFun i (cFun k X) γ - aFun i (aFun k X) γ
          + cFun k (cFun i X) γ - cFun k (aFun i X) γ
          + aFun k (cFun i X) γ - aFun k (aFun i X) γ) := by

  have hs2 : ((1 / Real.sqrt 2 : ℝ) : ℂ) * ((1 / Real.sqrt 2 : ℝ) : ℂ) = 1 / 2 := by
    rw [inv_sqrt_two_sq]; norm_num
  simp only [symProdFun, mFun, pFun, cFun_add, aFun_add, cFun_sub, aFun_sub, cFun_smul,
    aFun_smul, Pi.add_apply, Pi.sub_apply, Pi.smul_apply, smul_eq_mul]
  linear_combination (Complex.I / 2 * (cFun i (cFun k X) γ + cFun i (aFun k X) γ
      - aFun i (cFun k X) γ - aFun i (aFun k X) γ
      + cFun k (cFun i X) γ - cFun k (aFun i X) γ
      + aFun k (cFun i X) γ - aFun k (aFun i X) γ)) * hs2
