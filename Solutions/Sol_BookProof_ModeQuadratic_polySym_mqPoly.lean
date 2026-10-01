-- Generated from ChapterModeQuadraticEsa.lean — solution of BookProof.ModeQuadratic.polySym_mqPoly
import Mathlib
import Definitions.Def_ChapterModeQuadraticEsa
import Theorems.Thm_BookProof_ModeQuadratic_polySym_mqQuadPoly
import Theorems.Thm_BookProof_YangMillsHermite_PolySym_add
open BookProof.ModeQuadratic




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

set_option maxHeartbeats 1000000 in
theorem solution (p q s b b' : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (mqPoly p q s b b') := (polySym_mqQuadPoly p q s).add (polySym_foPoly b b')
