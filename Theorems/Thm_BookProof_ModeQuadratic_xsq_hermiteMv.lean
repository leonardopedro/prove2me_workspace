-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.xsq_hermiteMv
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
open BookProof.ModeQuadratic

variable {d : ℕ}



open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.ModeQuadratic.xsq_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly i) (hermiteMv a)
      = (1 : ℂ) • hermiteMv (a + Finsupp.single i 2)
        + (2 * (a i : ℂ) + 1) • hermiteMv a
        + ((a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • hermiteMv (a - Finsupp.single i 2) := by sorry
