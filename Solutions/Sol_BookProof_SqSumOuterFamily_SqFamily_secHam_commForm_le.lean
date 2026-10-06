-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.SqFamily.secHam_commForm_le
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Theorems.Thm_BookProof_SqSumFarisLavine_commForm_sqSumOp_le
import Theorems.Thm_BookProof_SqSumFarisLavine_sum_gradFun_sq_le_of_schur
open BookProof.SqSumOuterFamily
open BookProof.SqSumOuterFamily.SqFamily




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
theorem solution (n : ℕ) (u : polyGaussCore (d := F.dim n)) :
    |commForm (F.secHam n) harmCore u| ≤ F.flc * quadForm harmCore u := by

  have hM : ∀ x : Vd (F.dim n),
      ∑ k : Fin (F.dim n), (gradFun (F.vv n) k x) ^ 2 ≤ (F.a * F.b) ^ 2 * ‖x‖ ^ 2 :=
    fun x => sum_gradFun_sq_le_of_schur F.a_nonneg F.b_nonneg (F.row_le n) (F.col_le n) x
  have heq : F.km / 2 + 2 * (F.a * F.b) = F.flc := by rw [flc]
  rw [secHam, ← heq]
  exact commForm_sqSumOp_le F.km_nonneg (F.kap_le n) F.ab_nonneg hM u
