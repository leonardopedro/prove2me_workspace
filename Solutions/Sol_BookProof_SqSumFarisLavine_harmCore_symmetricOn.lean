-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.harmCore_symmetricOn
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Theorems.Thm_BookProof_QgHermiteFriedrichs_hamCore_symmetricOn
open BookProof.SqSumFarisLavine




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (polyGaussCore (d := D)) (harmCore (d := D)) := hamCore_symmetricOn _ _ _
