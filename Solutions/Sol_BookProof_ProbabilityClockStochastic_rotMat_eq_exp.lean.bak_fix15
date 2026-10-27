-- Generated from ChapterProbabilityClockStochastic.lean — solution of BookProof.ProbabilityClockStochastic.rotMat_eq_exp
import Mathlib
import Definitions.Def_ChapterProbabilityClockStochastic
import Theorems.Thm_BookProof_ProbabilityClockStochastic_Jgen_sq
open BookProof.ProbabilityClockStochastic




open Matrix
open scoped Norms.Operator

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) :
    NormedSpace.exp (a • Jgen) = rotMat a := by

  have hcont : Continuous ⇑(Complex.liftAux Jgen Jgen_sq) := by
    have := (Complex.liftAux Jgen Jgen_sq).toLinearMap.continuous_of_finiteDimensional
    simpa [AlgHom.coe_toLinearMap] using this
  have hfI : (Complex.liftAux Jgen Jgen_sq) (a • Complex.I) = a • Jgen := by
    rw [Complex.liftAux_apply]; simp [Complex.real_smul]
  have hval : NormedSpace.exp (a • Complex.I)
      = ((Real.cos a : ℂ)) + (Real.sin a : ℂ) * Complex.I := by
    rw [← Complex.exp_eq_exp_ℂ, Complex.real_smul, Complex.exp_mul_I,
      ← Complex.ofReal_cos, ← Complex.ofReal_sin]
  rw [← hfI]
  refine
    (NormedSpace.map_exp (Complex.liftAux Jgen Jgen_sq) hcont (a • Complex.I)).symm.trans ?_
  refine (congrArg (fun z : ℂ => Complex.liftAux Jgen Jgen_sq z) hval).trans ?_
  rw [Complex.liftAux_apply]
  simp only [Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, mul_zero, mul_one,
    sub_zero, add_zero, zero_add]
  rw [Algebra.algebraMap_eq_smul_one]
  ext i j; fin_cases i <;> fin_cases j <;> simp [Jgen, rotMat]
