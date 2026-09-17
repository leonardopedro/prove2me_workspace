-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.intertwine_cre
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_velIdx_apply
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_velIdx_raise
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_core_ext
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_cre_coreState
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_pgLp_smul
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coe
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_embedCore_coreState
import Theorems.Thm_BookProof_HermiteProductBasis_crePoly_hermiteMvLp
open BookProof.NavierStokesFlow.DifferentialL2




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) : (creOp i).comp embedCore = embedCore.comp (cre i) := by

  refine core_ext fun b => ?_
  refine Subtype.ext ?_
  simp only [LinearMap.comp_apply, creOp]
  have hR : ((embedCore (cre i (coreState b)) : polyGaussCore (d := 3)) : L2d 3)
      = ((Real.sqrt ((b i : ℝ) + 1) : ℝ) : ℂ) • hermiteMvLp (velIdx b + Finsupp.single i 1) := by
    rw [cre_coreState, map_smul, Submodule.coe_smul, embedCore_coe, coreState_coe,
      velUnitary_single, hermiteVel, velIdx_raise]
  rw [hR, embedCore_coreState, coreOp_coe, map_smul, pgLp_smul, crePoly_hermiteMvLp,
    velIdx_apply]
