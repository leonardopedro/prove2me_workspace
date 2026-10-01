-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.hermiteMvNorm_add_pvec
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.FullQuadratic

variable {d : ℕ}



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

theorem BookProof.FullQuadratic.hermiteMvNorm_add_pvec (i j : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + pvec i j) = hermiteMvNorm a * rcp a i j := by sorry
