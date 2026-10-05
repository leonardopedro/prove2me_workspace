-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.smComparison_quadForm
import Mathlib
import Definitions.Def_ChapterSmComparison
open BookProof.SmComparison




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.ScalaronWallEsa BookProof.ScalaronEsa BookProof.WallEsaBddBelow
open BookProof.TensorSumChain BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.EsaClosure BookProof.GraphCore
open BookProof.StoneBridge BookProof.ChapterStoneResolvent
open MeasureTheory

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c0 : ℝ) (x : polyGaussCore (d := 163)) :
    quadForm (smComparison c0) x
      = 2 * quadForm (weylOp smPi smConfField) x + c0 * ‖((x : polyGaussCore (d := 163)) :
          L2d 163)‖ ^ 2 := by

  have h1 : (inner ℂ ((x : polyGaussCore (d := 163)) : L2d 163) (smComparison c0 x) : ℂ)
      = (2 : ℂ) * inner ℂ ((x : polyGaussCore (d := 163)) : L2d 163)
          (weylOp smPi smConfField x)
        + ((c0 : ℝ) : ℂ) * inner ℂ ((x : polyGaussCore (d := 163)) : L2d 163)
          ((x : polyGaussCore (d := 163)) : L2d 163) := by
    simp [smComparison, LinearMap.add_apply, LinearMap.smul_apply, smul_apply, map_smul,
      inner_add_left, inner_add_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal,
      inner_self_eq_norm_sq_to_K, real_inner_self_eq_norm_sq, map_ofNat]
    show inner ℂ ((x : polyGaussCore (d := 163)) : L2d 163)
        (((c0 : ℝ) : ℂ) • ((x : polyGaussCore (d := 163)) : L2d 163))
      = ((c0 : ℝ) : ℂ) * (‖((x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 : ℂ)
    rw [inner_smul_right, inner_self_eq_norm_sq_to_K]
    rfl
  have h2 : (inner ℂ ((x : polyGaussCore (d := 163)) : L2d 163)
      ((x : polyGaussCore (d := 163)) : L2d 163) : ℂ)
      = ((‖((x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [quadForm, h1, h2, quadForm]
  simp only [Complex.ofReal_pow, Complex.add_re, Complex.mul_re, Complex.re_ofNat,
    Complex.im_ofNat, zero_mul, sub_zero, Complex.ofReal_re, Complex.ofReal_im, add_right_inj,
    mul_eq_mul_left_iff]
  left
  norm_cast
