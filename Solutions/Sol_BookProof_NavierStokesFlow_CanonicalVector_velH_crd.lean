-- Generated from ChapterNavierStokesCanonicalVector.lean — solution of BookProof.NavierStokesFlow.CanonicalVector.velH_crd
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_diagHop_hFun
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_pairHop_hFun
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_rotHop_hFun
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_shearHop_hFun
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_SignedShift_listH_coe
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector



open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 2000000 in
-- The four hopping families expand into twenty-odd ladder terms whose coordinatewise
-- matching is a single large `ring` normalisation; the default budget is not enough.
theorem solution (x : lpFiniteModes Vel) (γ : Vel) :
    ((velH A c (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))) x) :
        L2I Vel) : Vel → ℂ) γ
      = ladFun A c (crd x) γ := by

  rw [velH, SignedShift.listH_coe]
  simp only [hopList_eq, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
    diagHop_hFun, shearHop_hFun, pairHop_hFun, rotHop_hFun, ladFun, Fin.sum_univ_three,
    coe_inclusion_finiteModes, crd]
  push_cast
  ring
