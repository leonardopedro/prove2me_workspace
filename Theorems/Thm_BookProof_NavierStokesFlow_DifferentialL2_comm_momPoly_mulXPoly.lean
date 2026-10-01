-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.comm_momPoly_mulXPoly
import Mathlib
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}
variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

 -/
theorem BookProof.NavierStokesFlow.DifferentialL2.comm_momPoly_mulXPoly (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    ((momOp i (coreEquiv p) : polyGaussCore (d := d)) : L2d d)
      = pgLp (momPoly i p) := coreOp_coe _ p

/-- **The canonical commutation relation** `[πᵢ, u_k] = −i δ_{ik}` for the differential
ope := by sorry
