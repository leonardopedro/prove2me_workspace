-- Generated from ChapterSqSumFarisLavine.lean — solution of BookProof.SqSumFarisLavine.harmCore_symmetricOn
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine













open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

set_option maxHeartbeats 1000000 in
theorem solution : SymmetricOn (polyGaussCore (d := D)) (harmCore (d := D)) := hamCore_symmetricOn _ _ _
