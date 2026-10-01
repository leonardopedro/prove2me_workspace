-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.crd_mom
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_sub
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (x : lpFiniteModes Vel) :
    crd (mom i x) = mFun i (crd x) := by

  simp only [mom, mFun, LinearMap.smul_apply, LinearMap.sub_apply, crd_smul, crd_sub,
    crd_cre, crd_ann]
