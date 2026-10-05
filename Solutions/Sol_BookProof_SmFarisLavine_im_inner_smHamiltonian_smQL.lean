-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.im_inner_smHamiltonian_smQL
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_SmFarisLavine_im_neg_two_I_mul
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
theorem solution (P : SmParams) (x : polyGaussCore (d := 163)) :
    (inner ℂ (smHamiltonian P x) (smQL x) : ℂ).im
      = 1 / 2 * ∑ m : Fin 40, (-2) *
          (inner ℂ ((smPi m x : polyGaussCore (d := 163)) : L2d 163)
            ((smMomField m x : polyGaussCore (d := 163)) : L2d 163) : ℂ).re := by

  rw [inner_smHamiltonian,
    Finset.sum_congr rfl fun m (_ : m ∈ Finset.univ) => inner_smPi_sq_smQ m x,
    Finset.sum_congr rfl fun r (_ : r ∈ Finset.univ) => inner_smField_sq_smQ P r x,
    Complex.mul_im]
  simp only [Complex.ofReal_re, Complex.ofReal_im, zero_mul, add_zero]
  rw [Complex.add_im, Complex.im_sum, Complex.im_sum]
  simp only [Complex.add_im, Complex.ofReal_im, zero_add, im_neg_two_I_mul,
    Finset.sum_const_zero, add_zero]
