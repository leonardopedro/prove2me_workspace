-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.im_inner_smHamiltonian_smFlN
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_FarisLavine_inner_apply_self_im
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_symmetricOn
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.SmFarisLavine




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.HashimotoShiftInvert
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (c0 : ℝ)
    (x : polyGaussCore (d := 163)) :
    (inner ℂ (smHamiltonian P x) (smFlN P c0 x) : ℂ).im
      = (inner ℂ (smHamiltonian P x) (smQL x) : ℂ).im := by

  have h1 : (inner ℂ (smHamiltonian P x) (smHamiltonian P x) : ℂ).im = 0 := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  have h2 : (inner ℂ (smHamiltonian P x)
      ((x : polyGaussCore (d := 163)) : L2d 163) : ℂ).im = 0 :=
    inner_apply_self_im (smHamiltonian P) (smHamiltonian_symmetricOn P) x
  rw [smFlN_apply, inner_add_right, inner_add_right, inner_smul_right, inner_smul_right,
    Complex.add_im, Complex.add_im, Complex.mul_im, Complex.mul_im, h1, h2]
  simp
