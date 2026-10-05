-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.outerFriedN_esa
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_esa_self
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
theorem solution : EssentiallySelfAdjointOn (outerFriedDom dim) (outerFriedN dim) := (outerComparison dim).esa_self
