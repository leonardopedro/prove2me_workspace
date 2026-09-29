-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.hasDerivAt_gaussD_sec
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_norm_sq_sec
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
theorem solution (i : Fin d) (x : Vd d) (t : ℝ) :
    HasDerivAt (fun s : ℝ => gaussD (sec i x s)) (-(t / 2) * gaussD (sec i x t)) t := by

  classical
  set S := ∑ j ∈ Finset.univ.erase i, (x j) ^ 2 with hS
  have hfun : (fun s : ℝ => gaussD (sec i x s)) = fun s : ℝ => Real.exp (-(S + s ^ 2) / 4) := by
    funext s
    rw [gaussD, norm_sq_sec]
  rw [hfun]
  have h1 : HasDerivAt (fun s : ℝ => -(S + s ^ 2) / 4) (-(2 * t) / 4) t := by
    have h : HasDerivAt (fun s : ℝ => -(S + s ^ 2) / 4) (-(0 + 2 * t) / 4) t := by
      have h0 : HasDerivAt (fun s : ℝ => S + s ^ 2) (0 + 2 * t) t := by
        simpa using ((hasDerivAt_pow 2 t).const_add S)
      exact h0.neg.div_const 4
    simpa using h
  have h2 := (Real.hasDerivAt_exp (-(S + t ^ 2) / 4)).comp t h1
  convert h2 using 1
  rw [gaussD, norm_sq_sec]
  ring
