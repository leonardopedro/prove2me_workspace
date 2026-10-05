-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.sm_commForm_le
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_SmFarisLavine_im_inner_smHamiltonian_smQL
import Theorems.Thm_BookProof_SmFarisLavine_im_inner_smHamiltonian_smFlN
import Theorems.Thm_BookProof_SmFarisLavine_abs_re_inner_smPi_smMom_le
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
open BookProof.SmFarisLavine




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {c0 : ℝ} (hc0 : 0 ≤ c0)
    (x : polyGaussCore (d := 163)) :
    |commForm (smHamiltonian P) (smFlN P c0) x| ≤ 1 * quadForm (smFlN P c0) x := by

  set kin : ℝ := ∑ m : Fin 40,
    ‖((smPi m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 with hkin
  set har : ℝ := ∑ m : Fin 40,
    ‖((smMomField m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 with hhar
  set S : ℝ := ∑ m : Fin 40, (inner ℂ ((smPi m x : polyGaussCore (d := 163)) : L2d 163)
    ((smMomField m x : polyGaussCore (d := 163)) : L2d 163) : ℂ).re with hS
  have hform : commForm (smHamiltonian P) (smFlN P c0) x = 2 * S := by
    rw [commForm_eq, im_inner_smHamiltonian_smFlN, im_inner_smHamiltonian_smQL, hS,
      ← Finset.mul_sum]
    ring
  have hSbound : |S| ≤ 1 / 2 * (kin + har) := by
    refine (Finset.abs_sum_le_sum_abs _ _).trans ?_
    rw [hkin, hhar, ← Finset.sum_add_distrib, Finset.mul_sum]
    exact Finset.sum_le_sum fun m _ => abs_re_inner_smPi_smMom_le m x
  have hquad : kin + har ≤ quadForm (smFlN P c0) x := by
    rw [smFlN_quadForm, smHamiltonian_quadForm P, smQL_quadForm]
    have hf : (0 : ℝ) ≤ ∑ r : Fin 49,
        ‖((smField P r x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 :=
      Finset.sum_nonneg fun _ _ => by positivity
    have hx : (0 : ℝ) ≤ c0 * ‖((x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 := by positivity
    rw [hkin, hhar]
    linarith
  rw [hform, one_mul, abs_mul, abs_two]
  linarith [hSbound]
