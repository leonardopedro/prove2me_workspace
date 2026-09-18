import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadPoly_apply_eq_differential
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_pgFun_smul
import Theorems.Thm_BookProof_HyperbolicQuadratic_pgFun_add
import Theorems.Thm_BookProof_HyperbolicQuadratic_oscPoly_apply_eq_differential
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ)
    (x : Vd d) :
    pgFun (quadPoly c p) x
      = ∑ i, ((c i : ℝ) : ℂ)
          * (-(deriv (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec i x s)) t) (x i))
            + (((x i : ℝ) : ℂ) ^ 2 / 4) * pgFun p x) := by

  classical
  rw [quadPoly, LinearMap.sum_apply]
  induction (Finset.univ : Finset (Fin d)) using Finset.induction with
  | empty => simp [pgFun]
  | insert i s hi ih =>
      rw [Finset.sum_insert hi, Finset.sum_insert hi, pgFun_add, ih]
      congr 1
      rw [LinearMap.smul_apply, pgFun_smul, oscPoly_apply_eq_differential]
