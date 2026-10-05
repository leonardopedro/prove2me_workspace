-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.secData_commForm_le
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secHam_commForm_le
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_QgOuterFockFL_harmFried_op_core
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
theorem solution (n : ℕ) (p : (F.secData n).C₀) :
    |commForm (F.secData n).H₀ (F.secData n).coreN p|
      ≤ F.flc * quadForm (F.secData n).coreN p := by

  have hN : (F.secData n).coreN p = harmCore p :=
    harmFried_op_core (F.dim n) p _
  have h1 : commForm (F.secData n).H₀ (F.secData n).coreN p
      = commForm (F.secHam n) (harmCore (d := F.dim n)) p :=
    commForm_congr (F.secData n).H₀ (F.secData n).coreN (F.secHam n)
      (harmCore (d := F.dim n)) p p rfl hN
  have h2 : quadForm (F.secData n).coreN p = quadForm (harmCore (d := F.dim n)) p :=
    quadForm_congr (F.secData n).coreN (harmCore (d := F.dim n)) p p rfl hN
  rw [h1, h2]
  exact F.secHam_commForm_le n p
