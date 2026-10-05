-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.im_neg_two_I_mul
import Mathlib
import Definitions.Def_ChapterSmFarisLavine
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
theorem solution (z : ℂ) : (((-2 : ℂ) * Complex.I) * z).im = -2 * z.re := by

  simp [Complex.mul_im, Complex.mul_re]
