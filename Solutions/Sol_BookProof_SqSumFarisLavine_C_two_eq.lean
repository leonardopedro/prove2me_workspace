-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.C_two_eq
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution : (C (2 : ℂ) : MvPolynomial (Fin D) ℂ) = 2 := by

  rw [show (2 : ℂ) = ((2 : ℕ) : ℂ) by norm_num, MvPolynomial.C_eq_coe_nat]
  norm_num
