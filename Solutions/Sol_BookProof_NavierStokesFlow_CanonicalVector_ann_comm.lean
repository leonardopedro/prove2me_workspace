-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.ann_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_comm
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin 3) : (ann i).comp (ann k) = (ann k).comp (ann i) :=
  LinearMap.ext fun x => crd_injective (by
      simp only [LinearMap.comp_apply, crd_ann]
      exact aFun_comm i k (crd x))
