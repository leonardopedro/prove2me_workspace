import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.deriv2_pgFun_sec
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_deriv_pgFun_sec
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    deriv (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec i x s)) t) (x i)
      = pgFun (dPoly i (dPoly i p)) x := by

  have hfun : (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec i x s)) t)
      = fun t : ℝ => pgFun (dPoly i p) (sec i x t) := funext fun t => deriv_pgFun_sec i p x t
  rw [hfun, deriv_pgFun_sec i (dPoly i p) x (x i), sec_self]
