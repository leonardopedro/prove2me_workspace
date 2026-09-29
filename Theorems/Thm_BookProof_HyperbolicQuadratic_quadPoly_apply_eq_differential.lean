-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.quadPoly_apply_eq_differential
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

theorem BookProof.HyperbolicQuadratic.quadPoly_apply_eq_differential (c : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ)
    (x : Vd d) :
    pgFun (quadPoly c p) x
      = ∑ i, ((c i : ℝ) : ℂ)
          * (-(deriv (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec i x s)) t) (x i))
            + (((x i : ℝ) : ℂ) ^ 2 / 4) * pgFun p x) := by sorry
