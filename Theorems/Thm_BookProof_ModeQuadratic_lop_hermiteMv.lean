-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.lop_hermiteMv
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

theorem BookProof.ModeQuadratic.lop_hermiteMv (t : ℂ) (i : Fin d) (b : Fin d →₀ ℕ) :
    lop t i (hermiteMv b)
      = hermiteMv (b + Finsupp.single i 1) + (t * (b i : ℂ)) • hermiteMv (b - Finsupp.single i 1) := by sorry
