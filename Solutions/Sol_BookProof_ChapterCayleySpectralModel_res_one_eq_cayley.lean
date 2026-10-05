-- Generated from ChapterCayleySpectralModel.lean — solution of BookProof.ChapterCayleySpectralModel.res_one_eq_cayley
import Mathlib
import Definitions.Def_ChapterCayleySpectralModel
open BookProof.ChapterCayleySpectralModel



open scoped InnerProductSpace
open MeasureTheory


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent
open BookProof.ChapterCayleyTransform BookProof.ChapterAbelianGelfandModel
open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

set_option maxHeartbeats 1000000 in
theorem solution (y : H) :
    ((T.res 1 y : T.domain) : H) = (2 * Complex.I)⁻¹ • ((cayley T).symm y - y) := by

  have h2 : (2 * Complex.I : ℂ) ≠ 0 := by simp [Complex.I_ne_zero]
  have hy : T.shift 1 (T.res 1 y) = y := T.shift_res (by norm_num) y
  have hu : cayley T (T.shift (-1) (T.res 1 y)) = y := by rw [cayley_shift, hy]
  have husym := congrArg (cayley T).symm hu
  rw [LinearIsometryEquiv.symm_apply_apply] at husym
  have h := sub_cayley_shift T (T.res 1 y)
  rw [husym, LinearIsometryEquiv.apply_symm_apply] at h
  rw [h, smul_smul, inv_mul_cancel₀ h2, one_smul]
