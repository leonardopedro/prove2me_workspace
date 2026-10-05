-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.secExt_commForm_le
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secData_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_ext_commForm_le
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
variable (F : SqFamily)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (u : (harmFried (F.dim n)).dom) :
    |commForm (F.secExt n) (harmFried (F.dim n)).op u|
      ≤ F.flc * quadForm (harmFried (F.dim n)).op u := (F.secData n).ext_commForm_le (F.secData_commForm_le n) u
