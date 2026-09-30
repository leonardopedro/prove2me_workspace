-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.add_sub_single_eq_shiftm
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

theorem BookProof.FullQuadratic.add_sub_single_eq_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (hij : i ≠ j) :
    a + Finsupp.single j 1 - Finsupp.single i 1 = shiftm a j i := by sorry
