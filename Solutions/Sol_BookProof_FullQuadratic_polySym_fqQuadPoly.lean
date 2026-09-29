-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.polySym_fqQuadPoly
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.FullQuadratic

















open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P Q S : Fin d → Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (fqQuadPoly P Q S) := by

  refine polySym_sum _ _ fun i _ => ?_
  refine polySym_sum _ _ fun j _ => ?_
  refine ((BookProof.YangMillsHermite.weylProd_polySym (polySym_momPoly i)
      (polySym_momPoly j)).real_smul.add
    (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
      (polySym_mulXPoly j)).real_smul).add ?_
  exact (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
    (polySym_momPoly j)).real_smul
