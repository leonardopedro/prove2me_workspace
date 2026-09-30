-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.momsq_gen
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

theorem BookProof.FullQuadratic.momsq_gen (i j : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j) (hermiteMv a)
      = (-(1 / 4 : ℂ)) •
          BookProof.YangMillsHermite.weylProd (lop (-1) i) (lop (-1) j) (hermiteMv a) := by sorry
