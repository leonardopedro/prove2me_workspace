-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.crd_pos
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_add
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_smul
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) (x : lpFiniteModes Vel) :
    crd (pos i x) = pFun i (crd x) := by

  simp only [pos, pFun, LinearMap.smul_apply, LinearMap.add_apply, crd_smul, crd_add,
    crd_cre, crd_ann]
