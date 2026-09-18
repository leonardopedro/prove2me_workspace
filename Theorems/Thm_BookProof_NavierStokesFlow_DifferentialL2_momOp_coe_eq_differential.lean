-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.momOp_coe_eq_differential
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.DifferentialL2.momOp_coe_eq_differential (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    ((momOp i (coreEquiv p) : polyGaussCore (d := d)) : L2d d)
      = pgLp (momPoly i p) := by sorry
