-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.cre_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_comm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) : (cre i).comp (cre k) = (cre k).comp (cre i) :=
  LinearMap.ext fun x => crd_injective (by
      simp only [LinearMap.comp_apply, crd_cre]
      exact cFun_comm i k (crd x))
