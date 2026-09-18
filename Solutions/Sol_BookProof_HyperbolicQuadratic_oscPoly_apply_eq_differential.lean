import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.oscPoly_apply_eq_differential
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_deriv2_pgFun_sec
import Theorems.Thm_BookProof_HyperbolicQuadratic_pgFun_smul
import Theorems.Thm_BookProof_HyperbolicQuadratic_pgFun_add
import Theorems.Thm_BookProof_HyperbolicQuadratic_momPoly_sq_eq_dPoly
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (oscPoly i p) x
      = -(deriv (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec i x s)) t) (x i))
        + (((x i : ℝ) : ℂ) ^ 2 / 4) * pgFun p x := by

  have hx2 : pgFun ((1/4 : ℂ) • (X i * (X i * p))) x = (((x i : ℝ) : ℂ) ^ 2 / 4) * pgFun p x := by
    rw [pgFun_smul]
    have h1 : pgFun (X i * (X i * p)) x = ((x i : ℝ) : ℂ) * (((x i : ℝ) : ℂ) * pgFun p x) := by
      have e1 := posOp_apply_eq_mul i (mulXPoly i p) x
      have e2 := posOp_apply_eq_mul i p x
      simp only [mulXPoly_apply] at e1 e2
      rw [e1, e2]
    rw [h1]
    ring
  simp only [oscPoly, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    mulXPoly_apply]
  rw [pgFun_add, momPoly_sq_eq_dPoly, hx2, deriv2_pgFun_sec]
  congr 1
  simp only [pgFun, dPoly_apply, map_sub, MvPolynomial.smul_eval, map_mul,
    MvPolynomial.eval_X, map_neg, neg_mul]
