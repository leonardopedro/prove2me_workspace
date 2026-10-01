-- Generated from ChapterModeQuadraticEsa.lean — theorem BookProof.ModeQuadratic.polySym_mqQuadPoly
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

theorem BookProof.ModeQuadratic.polySym_mqQuadPoly (p q s : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (mqQuadPoly p q s) := by sorry
