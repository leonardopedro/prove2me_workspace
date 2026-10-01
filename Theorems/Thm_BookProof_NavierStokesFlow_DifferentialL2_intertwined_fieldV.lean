-- Generated from ChapterNavierStokesDifferentialL2.lean — theorem BookProof.NavierStokesFlow.DifferentialL2.intertwined_fieldV
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

affine field. -/
def nsDiffH : (polyGaussCore (d := 3)) →ₗ[ℂ] (polyGaussCore (d := 3)) :=
  ∑ i, ((1 : ℂ) / 2) • ((momOp i).comp (fieldOp A c i) + (fieldOp A c i).comp (momOp i))

set_option maxHeartbeats 4000000 in
-- The transport arguments unfold operators on a submodule of `L²(ℝ³)` through several
-- linear equivalences, so the defau := by sorry
