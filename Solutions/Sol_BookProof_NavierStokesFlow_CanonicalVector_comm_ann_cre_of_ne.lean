-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.comm_ann_cre_of_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_crd_injective
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_aFun_cFun_of_ne
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
theorem solution {i k : Fin 3} (h : i ≠ k) :
    (ann i).comp (cre k) = (cre k).comp (ann i) :=
  LinearMap.ext fun x => crd_injective (by
      simp only [LinearMap.comp_apply, crd_ann, crd_cre]
      exact aFun_cFun_of_ne h (crd x))
