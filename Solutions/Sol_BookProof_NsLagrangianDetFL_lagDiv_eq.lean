-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.lagDiv_eq
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_pderiv_vel_rename
import Theorems.Thm_BookProof_NsLagrangianDetFL_pderiv_disp_potP
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∑ i, pderiv i (lagDrift S i)
      = ((-(S.nu * ∑ j, lam S j) : ℝ) : ℂ) • (1 : MvPolynomial (PIdx K) ℂ) := by

  rw [Fintype.sum_prod_type, Fintype.sum_bool]
  simp only [lagDrift, map_sub, map_neg, pderiv_disp_potP, pderiv_vel_rename, sub_zero]
  have h0 : ∀ j : DIdx K,
      pderiv ((false, j) : PIdx K) (X (true, j) : MvPolynomial (PIdx K) ℂ) = 0 := by
    classical
    intro j; simp [pderiv_X]
  simp only [h0, Finset.sum_const_zero, add_zero]
  rw [Finset.mul_sum, ← Finset.sum_neg_distrib]
  push_cast
  rw [Finset.sum_smul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Derivation.map_smul, pderiv_X_self]
  module
