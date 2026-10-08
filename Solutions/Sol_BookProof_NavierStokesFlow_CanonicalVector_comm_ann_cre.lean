-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.comm_ann_cre
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_cFun_self
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_cFun_aFun_self
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_sub
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) :
    (ann i).comp (cre i) - (cre i).comp (ann i) = LinearMap.id := by

  refine LinearMap.ext fun x => crd_injective ?_
  funext β
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.id_apply, crd_sub,
    crd_ann, crd_cre, Pi.sub_apply, aFun_cFun_self, cFun_aFun_self]
  push_cast
  ring
