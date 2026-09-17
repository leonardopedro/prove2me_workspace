-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.hasDerivAt_pgFun_sec
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_sec_self
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_hasDerivAt_gaussD_sec
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_hasDerivAt_evalSec
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
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    HasDerivAt (fun t : ℝ => pgFun p (sec i x t))
      (pgFun (pderiv i p - (1/2 : ℂ) • (X i * p)) x) (x i) := by

  have hg : HasDerivAt (fun t : ℝ => ((gaussD (sec i x t) : ℝ) : ℂ))
      (((-(x i / 2) * gaussD x : ℝ)) : ℂ) (x i) := by
    have h := (hasDerivAt_gaussD_sec i x (x i)).ofReal_comp
    simpa using h
  have hp := hasDerivAt_evalSec i p x
  have h := hp.mul hg
  have hfun : (fun t : ℝ => pgFun p (sec i x t))
      = (fun t : ℝ => MvPolynomial.eval (fun j => (((sec i x t) j : ℝ) : ℂ)) p)
        * (fun t : ℝ => ((gaussD (sec i x t) : ℝ) : ℂ)) := by
    funext t; simp [pgFun]
  rw [hfun]
  convert h using 1
  rw [sec_self]
  simp only [pgFun, map_sub, MvPolynomial.smul_eval, map_mul, MvPolynomial.eval_X]
  push_cast
  ring
