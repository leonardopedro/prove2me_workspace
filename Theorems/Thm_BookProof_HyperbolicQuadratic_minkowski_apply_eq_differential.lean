-- Generated from ChapterHyperbolicQuadraticEsa.lean — theorem BookProof.HyperbolicQuadratic.minkowski_apply_eq_differential
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HyperbolicQuadratic



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

theorem BookProof.HyperbolicQuadratic.minkowski_apply_eq_differential (n : ℕ) (p : MvPolynomial (Fin (1 + n)) ℂ)
    (x : Vd (1 + n)) :
    pgFun (quadPoly (minkowskiCoeff n) p) x
      = (-(deriv (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec 0 x s)) t) (x 0))
          + (((x 0 : ℝ) : ℂ) ^ 2 / 4) * pgFun p x)
        - ∑ k ∈ Finset.univ.erase (0 : Fin (1 + n)),
            (-(deriv (fun t : ℝ => deriv (fun s : ℝ => pgFun p (sec k x s)) t) (x k))
              + (((x k : ℝ) : ℂ) ^ 2 / 4) * pgFun p x) := by sorry
