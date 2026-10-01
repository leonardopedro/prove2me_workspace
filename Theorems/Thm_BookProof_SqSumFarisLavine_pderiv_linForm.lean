-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.pderiv_linForm
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine

variable {D : ℕ} {R : Type*} [Fintype R]



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

theorem BookProof.SqSumFarisLavine.pderiv_linForm (v : Fin D → ℝ) (j : Fin D) :
    pderiv j (linForm v) = C ((v j : ℝ) : ℂ) := by sorry
