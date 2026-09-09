import Mathlib

/-!
# Chapter "Quantization due to time-evolution: Yang-Mills and Classical Statistical Field Theory",
§"Pure SU(3) Yang-Mills theory" — the structure constants

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(line ~7001).

The book opens the SU(3) construction with the defining relations of the
`SU(N)` generators `T_a` and their structure constants `f_{abc}`:

```
[T_a, T_b] = i f_{abc} T_c
tr(T_a T_b) = ½ δ_{ab}
```

(The electromagnetic case is recovered by dropping the `SU(N)` index and setting
`f_{abc} = 0`.)  This file formalizes the self-contained algebraic content of
these two relations.  Working with an arbitrary finite family of complex
matrices `T : Fin d → Matrix (Fin n) (Fin n) ℂ` satisfying the two hypotheses
above (with *real* structure constants `f`), we prove:

* `structureConstant_formula` — the closed formula recovering the structure
  constants from the trace, `f_{abd} = -2 i · tr([T_a, T_b] T_d)`, the algebraic
  reason the two book relations determine `f` uniquely;
* `structureConstant_antisymm_swap` — antisymmetry in the first two indices,
  `f_{abc} = - f_{bac}` (immediate from `[T_a, T_b] = -[T_b, T_a]`);
* `structureConstant_antisymm_rotate` — antisymmetry in the last two indices,
  `f_{abc} = - f_{acb}` (the genuine content, via cyclicity of the trace);
* `structureConstant_totally_antisymmetric` — the standard corollary that the
  structure constants are **totally antisymmetric** under any transposition of
  indices;
* `structureConstant_jacobi` — the **Jacobi identity for the structure
  constants**, `Σₑ (f_{abe} f_{ech} + f_{bce} f_{eah} + f_{cae} f_{ebh}) = 0`,
  obtained by projecting the matrix Jacobi identity onto the trace-orthonormal
  basis.  This is precisely the identity that makes the BRST charge `Ω`
  (with its cubic ghost term `f_{abc} ψ†_a ψ†_b ψ_c`) nilpotent.
-/

open Matrix BigOperators

namespace BookProof.YangMillsSU3

variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)

/-- Trace-orthonormality of the `SU(N)` generators: `tr(T_a T_b) = ½ δ_{ab}`. -/
def TraceOrthonormal : Prop :=
  ∀ a b, (T a * T b).trace = (if a = b then (1 / 2 : ℂ) else 0)

/-- The generators close under commutation with *real* structure constants:
`[T_a, T_b] = i f_{abc} T_c`. -/
def ClosesWithStructureConstants : Prop :=
  ∀ a b, T a * T b - T b * T a = Complex.I • ∑ c, (f a b c : ℂ) • T c

variable {T f}

/-
**Structure-constant formula.**  The two book relations recover the
structure constants from the trace: `f_{abd} = -2 i · tr([T_a, T_b] T_d)`.
-/
lemma structureConstant_formula
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b d : Fin d) :
    (f a b d : ℂ) = -2 * Complex.I * ((T a * T b - T b * T a) * T d).trace := by
  rw [ hf ];
  simp_all [ mul_assoc, Finset.mul_sum _ _ _, Finset.sum_mul ];
  simp_all [ ← mul_assoc, TraceOrthonormal ];
  ring

/-
**Antisymmetry in the first two indices**: `f_{abc} = - f_{bac}`.
-/
lemma structureConstant_antisymm_swap
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b c : Fin d) :
    f a b c = - f b a c := by
  have := structureConstant_formula hT hf a b c
  have := structureConstant_formula hT hf b a c
  simp_all [ Complex.ext_iff, mul_assoc ]
  simp [ sub_mul, mul_sub, Matrix.trace ]

/-
**Antisymmetry in the last two indices**: `f_{abc} = - f_{acb}`.
This is the genuine content, following from cyclicity of the trace.
-/
lemma structureConstant_antisymm_rotate
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b c : Fin d) :
    f a b c = - f a c b := by
  -- By definition of $f$, we know that $f_{abc} = -2i \cdot \text{tr}([T_a, T_b] T_c)$.
  have h_f_def : ∀ a b c, (f a b c : ℂ) = -2 * Complex.I * ((T a * T b - T b * T a) * T c).trace :=
    fun a b c => structureConstant_formula hT hf a b c
  rw [ ← Complex.ofReal_inj ] ; push_cast [ h_f_def ] ; ring;
  simp only [sub_mul, mul_assoc, trace_sub, Matrix.trace_mul_comm (T a), mul_sub, neg_sub];
  simp only [← mul_assoc, ← Matrix.trace_mul_comm (T b), sub_left_inj, mul_eq_mul_right_iff,
      mul_eq_mul_left_iff, Complex.I_ne_zero, or_false, OfNat.ofNat_ne_zero];
  rw [ ← Matrix.trace_mul_comm ] ; simp [ mul_assoc ]

/-- **Total antisymmetry** of the structure constants: swapping the first two
or the last two indices flips the sign. -/
lemma structureConstant_totally_antisymmetric
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f) :
    (∀ a b c, f a b c = - f b a c) ∧ (∀ a b c, f a b c = - f a c b) :=
  ⟨structureConstant_antisymm_swap hT hf, structureConstant_antisymm_rotate hT hf⟩

/-
**Jacobi identity for the structure constants**:
`Σₑ (f_{abe} f_{ech} + f_{bce} f_{eah} + f_{cae} f_{ebh}) = 0`,
the projection of the matrix Jacobi identity onto the trace-orthonormal basis.
This is the identity that makes the BRST charge nilpotent.
-/
lemma structureConstant_jacobi
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

end BookProof.YangMillsSU3
