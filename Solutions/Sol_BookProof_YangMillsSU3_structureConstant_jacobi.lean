-- Generated from ChapterYangMillsSU3.lean — solution of BookProof.YangMillsSU3.structureConstant_jacobi
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
open BookProof.YangMillsSU3








open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)



variable {T f}

set_option maxHeartbeats 1000000 in
theorem solution
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b c h : Fin d) :
    ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0 := by

  have h_sum_zero : ∑ e,    ∑ g,    (f a b e * f e c g + f b c e * f e a g + f c a e * f e b g) •
      Matrix.trace ((T g) * (T h)) = 0 := by
    have h_sum_zero : ∑ e,      ∑ g, (f a b e * f e c g + f b c e * f e a g + f c a e * f e b g) •
        (T g) = 0 := by
      -- Using the hypothesis `hf`, we can rewrite the commutators in terms of the structure
      -- constants.
      have h_comm : ∀ a b c,        (T a * T b - T b * T a) * T c - T c * (T a * T b - T b * T a) =
          - ∑ e,        ∑ g, (f a b e * f e c g : ℂ) • T g := by
        intros a b c
        have h_comm : (T a * T b - T b * T a) * T c - T c * (T a * T b - T b * T a) = Complex.I • (∑
            e, (f a b e : ℂ) • (T e * T c - T c * T e)) := by
          simp [ hf a b, Finset.mul_sum _ _ _, Finset.sum_mul, 
             ];
          simp only [smul_sub, Finset.sum_sub_distrib];
        convert h_comm using 1;
        simp only [Complex.coe_smul, Finset.smul_sum];
        rw [ ← Finset.sum_neg_distrib ] ; congr ; ext e ; rw [ hf e c ] ;
        simp only [neg_apply, Complex.coe_smul, Finset.smul_sum, smul_apply, smul_eq_mul] ;
        simp only [sum_apply, smul_apply, smul_eq_mul, Complex.real_smul, Complex.ext_iff,
          Complex.neg_re, Complex.re_sum, Complex.mul_re, Complex.ofReal_re,
          Complex.ofReal_im, mul_zero, sub_zero, Complex.mul_im, zero_mul, add_zero,
          Complex.I_re, Complex.I_im, one_mul, zero_sub, mul_neg, zero_add,
          Finset.sum_neg_distrib, neg_zero, Complex.im_sum, neg_inj, Complex.neg_im];
        exact ⟨ Finset.sum_congr rfl fun _ _ => by ring, Finset.sum_congr rfl fun _ _ => by ring ⟩;
      -- Applying the hypothesis `h_comm` to each term in the sum, we get:
      have h_sum_comm :
          ∑ e, ∑ g, (f a b e * f e c g + f b c e * f e a g + f c a e * f e b g : ℂ) • T g =
            -((T a * T b - T b * T a) * T c - T c * (T a * T b - T b * T a))
              - ((T b * T c - T c * T b) * T a - T a * (T b * T c - T c * T b))
              - ((T c * T a - T a * T c) * T b - T b * (T c * T a - T a * T c)) := by
        simp [ h_comm, Finset.sum_add_distrib, add_smul ];
      convert h_sum_comm using 1;
      · norm_cast;
      · grind +locals;
    convert congr_arg ( fun m => Matrix.trace ( m * T h ) ) h_sum_zero using 1;
    · simp [ Matrix.sum_mul, Matrix.trace_sum ];
    · norm_num;
  simp_all only [TraceOrthonormal, one_div, smul_ite, Complex.real_smul, Complex.ofReal_add,
    Complex.ofReal_mul, smul_zero, Finset.sum_ite_eq', Finset.mem_univ, ↓reduceIte];
  rw [ ← @Complex.ofReal_inj ] ; simp_all [ ← Finset.sum_mul _ _ _ ]
