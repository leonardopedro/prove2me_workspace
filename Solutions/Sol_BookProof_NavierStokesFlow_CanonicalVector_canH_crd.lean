-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canH_crd
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_mom
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_fieldV
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes Vel) (γ : Vel) :
    crd (canH A c x) γ = canFun A c (crd x) γ := by

  simp only [canH, canFun, Fin.sum_univ_three, LinearMap.smul_apply,
    LinearMap.add_apply, LinearMap.comp_apply, crd_smul, crd_add, crd_mom, crd_fieldV,
    Pi.add_apply, Pi.smul_apply, smul_eq_mul]
