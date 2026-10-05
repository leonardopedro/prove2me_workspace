-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.outerFriedN_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
open BookProof.SqSumOuterFamily




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

variable (dim : ℕ → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution (x : outerFriedDom dim) :
    0 ≤ quadForm (outerFriedN dim) x := (outerComparison dim).pos x
