-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.weylProd_smul_apply
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

theorem BookProof.FullQuadratic.weylProd_smul_apply (c c' : ℂ) (A B : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (p : MvPolynomial (Fin d) ℂ) :
    BookProof.YangMillsHermite.weylProd (c • A) (c' • B) p
      = (c * c') • BookProof.YangMillsHermite.weylProd A B p := by sorry
