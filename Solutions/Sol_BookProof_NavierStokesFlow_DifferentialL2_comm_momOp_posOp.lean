-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.comm_momOp_posOp
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coreEquiv
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_comm_momPoly_mulXPoly
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i k : Fin d) :
    (momOp i).comp (posOp k) - (posOp k).comp (momOp i)
      = (if i = k then -Complex.I else 0) • LinearMap.id := by

  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := d)).surjective y
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, posOp, momOp, coreOp_coreEquiv,
    LinearMap.smul_apply, LinearMap.id_apply]
  rw [← map_sub, comm_momPoly_mulXPoly, ← MvPolynomial.smul_eq_C_mul, map_smul]
