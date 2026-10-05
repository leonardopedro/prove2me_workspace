-- Generated from ChapterNsLagrangianDetFarisLavine.lean — solution of BookProof.NsLagrangianDetFL.abs_eval_lagFlux_le
import Mathlib
import Definitions.Def_ChapterNsLagrangianDetFarisLavine
import Theorems.Thm_BookProof_NsLagrangianDetFL_lam_nonneg
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_lagFlux_re
import Theorems.Thm_BookProof_NsLagrangianDetFL_eval_lagEnergy_ge
open BookProof.NsLagrangianDetFL




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.KoopmanLyapunov BookProof.NsLagrangianDet

noncomputable section

variable {K : Type*} [Fintype K]

variable {K : Type*} [Fintype K]
variable (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution (z : PIdx K → ℝ) :
    |(MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagFlux S)).re|
      ≤ (2 * S.nu * ∑ j, lam S j)
        * (MvPolynomial.eval (fun i => ((z i : ℝ) : ℂ)) (lagEnergy S)).re := by

  have hE := eval_lagEnergy_ge S z
  rw [eval_lagFlux_re]
  set L := ∑ j, lam S j
  have hL : ∀ j, lam S j ≤ L := fun j =>
    Finset.single_le_sum (fun l _ => lam_nonneg S l) (Finset.mem_univ j)
  have hL0 : 0 ≤ L := Finset.sum_nonneg fun l _ => lam_nonneg S l
  have hs0 : 0 ≤ ∑ j : DIdx K, lam S j * z (true, j) ^ 2 :=
    Finset.sum_nonneg fun j _ => mul_nonneg (lam_nonneg S j) (sq_nonneg _)
  have hsq : 0 ≤ ∑ j : DIdx K, z (true, j) ^ 2 := Finset.sum_nonneg fun j _ => sq_nonneg _
  have hsL : ∑ j : DIdx K, lam S j * z (true, j) ^ 2 ≤ L * ∑ j : DIdx K, z (true, j) ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun j _ => mul_le_mul_of_nonneg_right (hL j) (sq_nonneg _)
  have hnu := S.nu_nonneg
  rw [abs_neg, abs_of_nonneg (mul_nonneg hnu hs0)]
  have h1 : S.nu * ∑ j : DIdx K, lam S j * z (true, j) ^ 2
      ≤ S.nu * (L * ∑ j : DIdx K, z (true, j) ^ 2) := mul_le_mul_of_nonneg_left hsL hnu
  nlinarith [mul_nonneg hnu hL0]
