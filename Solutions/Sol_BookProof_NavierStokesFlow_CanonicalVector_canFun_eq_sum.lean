-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canFun_eq_sum
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_mFun_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_mFun_smul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (X : Vel → ℂ) (γ : Vel) :
    canFun A c X γ
      = ∑ i, ((∑ k, ((A i k : ℝ) : ℂ) * symProdFun i k X γ) + ((c i : ℝ) : ℂ) * mFun i X γ) := by

  simp only [canFun, vFun, symProdFun, Fin.sum_univ_three, mFun_add, mFun_smul,
    Pi.add_apply, Pi.smul_apply, smul_eq_mul]
  ring
