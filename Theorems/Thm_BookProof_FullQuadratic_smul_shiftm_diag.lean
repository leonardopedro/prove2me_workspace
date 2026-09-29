-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.smul_shiftm_diag
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

theorem BookProof.FullQuadratic.smul_shiftm_diag (c : ℂ) (a : Fin d →₀ ℕ) (i : Fin d) :
    (c * (a i : ℂ)) • hermiteMv (shiftm a i i) = (c * (a i : ℂ)) • hermiteMv a := by sorry
