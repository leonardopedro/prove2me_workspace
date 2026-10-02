-- Generated from ChapterNavierStokesDifferentialL2.lean — solution of BookProof.NavierStokesFlow.DifferentialL2.posOp_apply_eq_mul
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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
m operator** `πᵢ = −i ∂/∂uᵢ` on the Hermite core of `L²(ℝᵈ)`. -/
def momOp (i : Fin d) : (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  coreOp (momPoly i)

/-- **The position operator is mu := ltiplication by the coordinate**, poi
