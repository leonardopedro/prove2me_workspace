-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.cpoly_linForm
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine












open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

theorem BookProof.SqSumFarisLavine.cpoly_linForm (v : Fin D → ℝ) : cpoly (linForm v) = linForm v := by sorry
