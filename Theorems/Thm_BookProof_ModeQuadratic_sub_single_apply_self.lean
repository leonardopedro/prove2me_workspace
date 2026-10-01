-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.sub_single_apply_self
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

theorem BookProof.ModeQuadratic.sub_single_apply_self (i : Fin d) (a : Fin d →₀ ℕ) :
    (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by sorry
