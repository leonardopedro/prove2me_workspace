-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.oscOp_eq_number
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Theorems.Thm_BookProof_NavierStokesFlow_DiffFarisLavine_oscPoly_eq
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coreEquiv
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine





open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat BookProof.FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) :
    oscOp i = (creOp i).comp (annOp i) + ((1 / 2 : ℂ)) • LinearMap.id := by

  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 3)).surjective y
  simp only [oscOp, momOp, posOp, annOp, creOp, coreOp_coreEquiv, LinearMap.add_apply,
    LinearMap.comp_apply, LinearMap.smul_apply, LinearMap.id_apply, ← map_add, ← map_smul]
  congr 1
  exact oscPoly_eq i p
