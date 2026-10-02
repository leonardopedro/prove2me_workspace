-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.canH_eq_velH
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_velH_crd
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canH_crd
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canFun_eq_ladFun
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    (lpFiniteModes Vel).subtype.comp (canH A c)
      = (velH A c).comp (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c)))) := by

  refine LinearMap.ext fun x => lp.ext (funext fun γ => ?_)
  simp only [LinearMap.comp_apply, Submodule.subtype_apply]
  rw [velH_crd]
  exact (canH_crd A c x γ).trans (canFun_eq_ladFun A c (crd x) γ)
