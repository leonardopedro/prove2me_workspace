-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.fqQuadPoly_rotMat
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

theorem BookProof.FullQuadratic.fqQuadPoly_rotMat (k l : Fin d) :
    fqQuadPoly (d := d) 0 0 (rotMat k l)
      = BookProof.YangMillsHermite.weylProd (mulXPoly k) (momPoly l)
        - BookProof.YangMillsHermite.weylProd (mulXPoly l) (momPoly k) := by sorry
