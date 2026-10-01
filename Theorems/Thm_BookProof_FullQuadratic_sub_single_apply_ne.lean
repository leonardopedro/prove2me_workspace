-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.sub_single_apply_ne
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

theorem BookProof.FullQuadratic.sub_single_apply_ne {a : Fin d →₀ ℕ} {i j : Fin d} (hij : i ≠ j) :
    ((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) = a i := by sorry
