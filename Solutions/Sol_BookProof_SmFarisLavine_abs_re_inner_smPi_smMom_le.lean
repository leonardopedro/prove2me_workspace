-- Generated from ChapterSmFarisLavine.lean — solution of BookProof.SmFarisLavine.abs_re_inner_smPi_smMom_le
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
theorem solution (m : Fin 40) (x : polyGaussCore (d := 163)) :
    |(inner ℂ ((smPi m x : polyGaussCore (d := 163)) : L2d 163)
        ((smMomField m x : polyGaussCore (d := 163)) : L2d 163) : ℂ).re|
      ≤ 1 / 2 * (‖((smPi m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2
        + ‖((smMomField m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2) := by

  have h := (Complex.abs_re_le_norm
    (inner ℂ ((smPi m x : polyGaussCore (d := 163)) : L2d 163)
      ((smMomField m x : polyGaussCore (d := 163)) : L2d 163) : ℂ)).trans
    (norm_inner_le_norm _ _)
  nlinarith [sq_nonneg (‖((smPi m x : polyGaussCore (d := 163)) : L2d 163)‖
    - ‖((smMomField m x : polyGaussCore (d := 163)) : L2d 163)‖)]
