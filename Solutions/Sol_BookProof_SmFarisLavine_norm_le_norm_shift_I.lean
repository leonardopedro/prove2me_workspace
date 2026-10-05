-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.norm_le_norm_shift_I
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
import Theorems.Thm_BookProof_FarisLavine_inner_apply_self_im
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
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (A : D →ₗ[ℂ] F) (hA : SymmetricOn D A)
    (z : D) : ‖(z : F)‖ ≤ ‖A z - (-Complex.I) • (z : F)‖ := by

  have hre : (inner ℂ (A z) ((z : F)) : ℂ).im = 0 := inner_apply_self_im A hA z
  have hrw : A z - (-Complex.I) • (z : F) = A z + Complex.I • (z : F) := by module
  have hcross : (inner ℂ (A z) (Complex.I • (z : F)) : ℂ).re = 0 := by
    rw [inner_smul_right, Complex.mul_re, Complex.I_re, Complex.I_im, hre]
    ring
  have hnorm : ‖Complex.I • (z : F)‖ = ‖(z : F)‖ := by
    rw [norm_smul]
    simp
  have hexp : ‖A z - (-Complex.I) • (z : F)‖ ^ 2 = ‖A z‖ ^ 2 + ‖(z : F)‖ ^ 2 := by
    rw [hrw, norm_add_sq_re, hcross, hnorm]
    ring
  nlinarith [norm_nonneg (A z), norm_nonneg ((z : F)),
    norm_nonneg (A z - (-Complex.I) • (z : F)), hexp]
