-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.canH_coe_velH
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_CanonicalVector_canH_eq_velH
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_finiteModes_le_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution (x : lpFiniteModes Vel) :
    ((canH A c x : lpFiniteModes Vel) : L2I Vel)
      = velH A c (Submodule.inclusion (finiteModes_le_maxDom (velSym (velMu A c))) x) := by

  have h := congrFun (congrArg (fun T : lpFiniteModes Vel →ₗ[ℂ] L2I Vel => ⇑T)
    (canH_eq_velH A c)) x
  simpa using h
