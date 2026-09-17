-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.momOp_eq_ladder
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coreEquiv
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
set_option maxHeartbeats 1000000 in
-- Unfolding the core coordinates through three linear equivalences is elaboration-heavy.
theorem solution (i : Fin 3) :
    momOp i = (Complex.I / 2) • (creOp i - annOp i) := by

  refine LinearMap.ext fun y => ?_
  obtain ⟨p, rfl⟩ := (coreEquiv (d := 3)).surjective y
  simp only [momOp, annOp, creOp, coreOp_coreEquiv, LinearMap.smul_apply, LinearMap.sub_apply,
    ← map_sub, ← map_smul]
  congr 1
  have hI : (C (Complex.I / 2) : MvPolynomial (Fin 3) ℂ) = C Complex.I * C (1 / 2 : ℂ) := by
    rw [← map_mul]
    congr 1
    ring
  have h2 : (C (1 / 2 : ℂ) : MvPolynomial (Fin 3) ℂ) * 2 = 1 := by
    rw [← map_ofNat C 2, ← map_mul]
    norm_num
  simp only [momPoly_apply, annPoly_apply, crePoly_apply, MvPolynomial.smul_eq_C_mul, map_neg,
    hI]
  linear_combination (C Complex.I * (pderiv i) p) * h2
