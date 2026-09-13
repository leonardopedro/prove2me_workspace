-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.phi_at_zero
import Mathlib
import Definitions.Def_ChapterH1
import Theorems.Thm_BookProof_ChapterH1_phi_succ_apply
import Theorems.Thm_BookProof_ChapterH1_phi_zero_apply
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : phi k 0 = 1 / k.factorial := by

  induction k with
  | zero => ?_
  | succ k ih => ?_
  · norm_num [ phi_zero_apply ];
  · simp only [phi_succ_apply, mul_zero, Complex.exp_zero, one_mul, integral_div, one_div];
    norm_cast;
    erw [ intervalIntegral.integral_ofReal, intervalIntegral.integral_comp_sub_left fun x => x ^ k ]
        ;      norm_num [ Nat.factorial_succ ];
    ring
