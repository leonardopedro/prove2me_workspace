-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.phi_succ_mul
import Mathlib
import Definitions.Def_ChapterH1
import Theorems.Thm_BookProof_ChapterH1_phi_at_zero
open BookProof.ChapterH1



open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (z : ℂ) :
    z * phi (k + 1) z = phi k z - 1 / k.factorial := by

  by_cases h : z = 0
    <;> simp_all only [zero_mul, div_eq_inv_mul, mul_one];
  · rw [ phi_at_zero ] ; ring;
  · have h_int_parts : ∫ s in (0 : ℝ)..1,    deriv (fun s => Complex.exp (s * z) * (1 - s) ^ k) s =
      (Complex.exp (1 * z) * (1 - 1) ^ k) - (Complex.exp (0 * z) * (1 - 0) ^ k) := by
      rw [ intervalIntegral.integral_eq_sub_of_hasDerivAt ];
      rotate_right;
      focus (use fun x => Complex.exp ( x * z ) * ( 1 - x ) ^ k);
      · norm_num;
      · intro x hx
        have hdiff : DifferentiableAt ℂ (fun s => Complex.exp (s * z) * (1 - s) ^ k) (x : ℂ) := by
          refine DifferentiableAt.mul (Complex.differentiableAt_exp.comp _ ?_) <|
            DifferentiableAt.pow (differentiableAt_id.const_sub _) _
          exact differentiableAt_id.mul_const _
        have hderiv : HasDerivAt (fun s : ℂ => Complex.exp (s * z) * (1 - s) ^ k)
            (deriv (fun s : ℂ => Complex.exp (s * z) * (1 - s) ^ k) (x : ℂ)) (x : ℂ) :=
          hasDerivAt_deriv_iff.mpr hdiff
        simpa using hderiv.comp_ofReal
      · apply_rules [ Continuous.intervalIntegrable ];
        fun_prop;
    have h_int_parts : ∫ s in (0 : ℝ)..1,      deriv (fun s => Complex.exp (s * z) * (1 - s) ^ k) s
        = ∫ s in (0 : ℝ)..1,      (z * Complex.exp (s * z) * (1 - s) ^ k - k * Complex.exp (s * z) *
            (1 - s) ^ (k - 1)) := by
      refine intervalIntegral.integral_congr fun x hx => ?_
      have h1 : HasDerivAt (fun s : ℂ => Complex.exp (s * z)) (Complex.exp (x * z) * z) (x : ℂ) :=
        (Complex.hasDerivAt_exp ((x : ℂ) * z)).comp (x : ℂ) (hasDerivAt_mul_const z)
      have h2 : HasDerivAt (fun s : ℂ => (1 - s) ^ k)
          ((k : ℂ) * (1 - (x : ℂ)) ^ (k - 1) * (-1)) (x : ℂ) :=
        ((hasDerivAt_id' (x : ℂ)).const_sub 1).pow k
      have hC : HasDerivAt (fun s : ℂ => Complex.exp (s * z) * (1 - s) ^ k)
          (Complex.exp (x * z) * z * (1 - (x : ℂ)) ^ k
            + Complex.exp (x * z) * ((k : ℂ) * (1 - (x : ℂ)) ^ (k - 1) * (-1))) (x : ℂ) :=
        h1.mul h2
      rw [hC.deriv]
      ring
    rcases k with ( _ | k ) <;> simp_all only [pow_zero, mul_one, differentiableAt_fun_id,
                                  differentiableAt_const,
                                  DifferentiableAt.fun_mul,
                                  deriv_cexp, deriv_fun_mul,
                                  deriv_id'', one_mul,
                                  deriv_const', mul_zero,
                                  add_zero, integral_mul_const,
                                  sub_self, zero_mul,
                                  Complex.exp_zero, sub_zero,
                                  CharP.cast_eq_zero, zero_tsub,
                                  integral_const_mul, zero_add,
                                  phi_zero_apply,
                                  Nat.factorial_zero,
                                  Nat.cast_one, inv_one,
                                  mul_eq_mul_left_iff, or_false,
                                  mul_assoc, Nat.cast_add,
                                  add_tsub_cancel_right, ne_eq,
                                  Nat.add_eq_zero_iff,
                                  one_ne_zero, and_fals
