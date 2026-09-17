-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.pgFun_smul
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r : ℂ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (r • p) x = r * pgFun p x := by

  simp [pgFun, MvPolynomial.smul_eval]
  ring
