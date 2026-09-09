import Mathlib

/-!
# Chapter "Free field parametrization in Classical Statistical Field Theory and
Navier-Stokes equations" — §"Quadratic Ordering"

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier-Stokes equations"*, section *"Quadratic Ordering"*
(line ~4031).

The book contrasts two ways of ordering operators:

> *"The (symmetric) Weyl ordering of operators conserves the exponential of
> operators, unlike normal-ordering. This is an important property of the
> ordering, because we use often the Trotter product formula (e.g. in the
> time-evolution operator)."*

This file formalizes the precise algebraic fact underlying that statement — the
**central Baker–Campbell–Hausdorff identity** — in an arbitrary complex/real
Banach algebra `𝔸` of operators.  When the commutator `C = A·B − B·A` is
*central* (it commutes with both `A` and `B` — the Heisenberg / canonical
commutation situation, where `C` is a scalar), the two exponentials do not simply
multiply; instead

```
exp A · exp B  =  exp (A + B) · exp (½·C).
```

The right-hand product `exp A · exp B` (with all `A`-factors to the left of the
`B`-factors) is exactly the **normal-ordered** exponential, whereas the
symmetric factor `exp (A + B)` is the **Weyl / symmetric-ordered** exponential.
The two agree precisely up to the central *correction factor* `exp (½·C)`: the
symmetric ordering reproduces `exp(A+B)` on the nose, while normal ordering
carries the extra `exp(½·C)` — the formal content of *"Weyl ordering conserves
the exponential, unlike normal-ordering"*.

Contents (all `sorry`-free and `axiom`-free — only `propext`, `Classical.choice`,
`Quot.sound`):

* `exp_of_sq_eq_zero` — `exp x = 1 + x` for a square-zero element (`x^2 = 0`); the
  exponential of a nilpotent commutator truncates.
* `exp_smul_mul_central` — the **adjoint identity**
  `exp (t•A) · B = (B + t•C) · exp (t•A)` whenever `C = A·B − B·A` commutes with
  `A`.
* `exp_mul_exp_central` — the **central BCH identity**
  `exp A · exp B = exp (A + B) · exp (½•C)` (normal ordering vs. symmetric
  ordering).
* `exp_add_central` — the equivalent form `exp (A + B) = exp A · exp B · exp(−½•C)`
  recovering the symmetric exponential from the normal-ordered product.
* `symmetric_ordering_correction_of_sq_zero` — in the nilpotent (Heisenberg-type)
  case `C^2 = 0`, the correction is the affine factor `1 + ½•C`:
  `exp A · exp B = exp (A + B) · (1 + ½•C)`.
-/

namespace BookProof.QuadraticOrdering

open NormedSpace

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℝ 𝔸] [CompleteSpace 𝔸]

omit [CompleteSpace 𝔸] in
/-- **Exponential of a square-zero element truncates:** if `x^2 = 0` then
`exp x = 1 + x`.  (The exponential series of a nilpotent element is a finite sum;
this is the two-term case used for a nilpotent commutator.) -/
theorem exp_of_sq_eq_zero (x : 𝔸) (hx : x ^ 2 = 0) : exp x = 1 + x := by
  haveI hQ : NormedAlgebra ℚ 𝔸 := NormedAlgebra.restrictScalars ℚ ℝ 𝔸
  have hpow : ∀ n, 2 ≤ n → x ^ n = 0 := by
    intro n hn
    obtain ⟨m, rfl⟩ := Nat.exists_eq_add_of_le hn
    rw [pow_add, hx, zero_mul]
  rw [NormedSpace.exp_eq_tsum (𝕂 := ℝ)]
  simp only []
  rw [tsum_eq_sum (s := {0, 1}) ?_]
  · simp
  · intro n hn
    simp only [Finset.mem_insert, Finset.mem_singleton] at hn
    push_neg at hn
    obtain ⟨h0, h1⟩ := hn
    have hxn : x ^ n = 0 := hpow n (by omega)
    rw [hxn, smul_zero]

/-
**Adjoint identity.**  If the commutator `C = A·B − B·A` commutes with `A`
(equivalently `⁅A, ⁅A,B⁆⁆ = 0`), then for every real `t`
```
exp (t•A) · B = (B + t•C) · exp (t•A).
```
This is the linearized `exp(tA) B exp(−tA) = B + t·C` written multiplicatively
(no inverse), the single-adjoint truncation of the BCH series.
-/
theorem exp_smul_mul_central (A B : 𝔸) (hA : Commute A (A * B - B * A)) (t : ℝ) :
    exp (t • A) * B = (B + t • (A * B - B * A)) * exp (t • A) := by
  -- We'll use the exponential property: $\exp(tA) B \exp(-tA) = B + tC$.
  have h_exp : ∀ t : ℝ,    (NormedSpace.exp (t • A)) * B * (NormedSpace.exp (-t • A)) = B + t • (A *
      B - B * A) := by
    intro t
    have h_deriv : ∀ t : ℝ,      HasDerivAt (fun s => (NormedSpace.exp (s • A)) * B *
        (NormedSpace.exp (-s • A))) (A * B - B * A) t := by
      intro t
      have h_deriv : HasDerivAt (fun s => (NormedSpace.exp (s • A)) * B * (NormedSpace.exp (-s •
          A))) ((NormedSpace.exp (t • A)) * A * B * (NormedSpace.exp (-t • A)) - (NormedSpace.exp (t
              • A)) * B * A * (NormedSpace.exp (-t • A))) t := by
        have h_deriv : HasDerivAt (fun s => (NormedSpace.exp (s • A)) * B) ((NormedSpace.exp (t •
            A)) * A * B) t := by
          have := @hasDerivAt_exp_smul_const;
          simpa using HasDerivAt.mul ( this A t ) ( hasDerivAt_const _ _ );
        have h_deriv : HasDerivAt (fun s => (NormedSpace.exp (-s • A))) (-A * (NormedSpace.exp (-t •
            A))) t := by
          have := @hasDerivAt_exp_smul_const' ℝ;
          convert this ( -A ) t using 1; all_goals simp [ neg_smul ];
        convert HasDerivAt.mul ‹HasDerivAt ( fun s => exp ( s • A ) * B ) ( exp ( t • A ) * A * B )
            t› h_deriv using 1 ; simp [ mul_assoc, sub_eq_add_neg ];
      have h_comm : (NormedSpace.exp (t • A)) * (A * B - B * A) = (A * B - B * A) * (NormedSpace.exp
          (t • A)) := by
        have h_comm : ∀ s : ℝ,          (NormedSpace.exp (s • A)) * (A * B - B * A) = (A * B - B *
            A) * (NormedSpace.exp (s • A)) := by
          intro s;
          have h_comm : ∀ s : ℝ, Commute (s • A) (A * B - B * A) := by
            exact fun s => hA.smul_left s;
          have h_comm : ∀ s : ℝ, Commute (NormedSpace.exp (s • A)) (A * B - B * A) := by
            intro s;
            apply Commute.exp_left;
            exact h_comm s;
          exact h_comm s;
        exact h_comm t;
      have h_comm : (NormedSpace.exp (t • A)) * (NormedSpace.exp (-t • A)) = 1 := by
        have h_comm : ∀ x y : 𝔸,          Commute x y → NormedSpace.exp (x + y) = NormedSpace.exp x
            * NormedSpace.exp y := by
          intro x y hxy;
          convert NormedSpace.exp_add_of_commute hxy;
          exact NormedAlgebra.restrictScalars ℚ ℝ 𝔸;
        rw [ ← h_comm ] <;> norm_num;
      simp_all only [neg_smul, mul_assoc, mul_sub, sub_mul];
      convert h_deriv using 1;
      simp_all [ ← mul_assoc ];
      simp_all [ mul_assoc, sub_eq_iff_eq_add ];
      simp_all [ mul_assoc, add_mul, sub_mul ];
    have h_integral : ∀ a b : ℝ,      ∫ x in a..b,      deriv (fun s => (NormedSpace.exp (s • A)) *
        B * (NormedSpace.exp (-s • A))) x = (NormedSpace.exp (b • A)) * B * (NormedSpace.exp (-b •
            A)) - (NormedSpace.exp (a • A)) * B * (NormedSpace.exp (-a • A)) := by
      intro a b;
      rw [ intervalIntegral.integral_deriv_eq_sub ];
      · exact fun x hx => HasDerivAt.differentiableAt ( h_deriv x );
      · rw [ show deriv _ = _ from funext fun x => HasDerivAt.deriv ( h_deriv x ) ] ; norm_num;
    have := h_integral 0 t;      rw [ funext fun x => HasDerivAt.deriv ( h_deriv x ) ] at this;
        norm_num at this;
    simp_all [ smul_sub, sub_eq_iff_eq_add' ];
  have h_exp_neg : exp (-t • A) * exp (t • A) = 1 := by
    have h_exp_neg : ∀ x y : 𝔸,      Commute x y → NormedSpace.exp x * NormedSpace.exp y =
        NormedSpace.exp (x + y) := by
      haveI := NormedAlgebra.restrictScalars ℚ ℝ 𝔸
      exact fun x y hxy => (NormedSpace.exp_add_of_commute hxy).symm
    rw [ h_exp_neg ] <;> norm_num;
  rw [ ← h_exp t, mul_assoc, h_exp_neg, mul_one ]

/-- Derivative of the **normal-ordered curve** `s ↦ exp (s•A) · exp (s•B)`.  Using
the adjoint identity `exp_smul_mul_central`, it satisfies the linear ODE
`y'(t) = (A + B + t•C) · y(t)` with `C = A·B − B·A`. -/
theorem hasDerivAt_normalCurve (A B : 𝔸) (hA : Commute A (A * B - B * A)) (t : ℝ) :
    HasDerivAt (fun s : ℝ => exp (s • A) * exp (s • B))
      ((A + B + t • (A * B - B * A)) * (exp (t • A) * exp (t • B))) t := by
  have hdA : HasDerivAt (fun s : ℝ => exp (s • A)) (exp (t • A) * A) t :=
    hasDerivAt_exp_smul_const A t
  have hdB : HasDerivAt (fun s : ℝ => exp (s • B)) (B * exp (t • B)) t :=
    hasDerivAt_exp_smul_const' B t
  have hmul := hdA.mul hdB
  convert hmul using 1
  have hcommA : exp (t • A) * A = A * exp (t • A) :=
    ((Commute.refl A).smul_left t).exp_left.eq
  have hadj : exp (t • A) * B = (B + t • (A * B - B * A)) * exp (t • A) :=
    exp_smul_mul_central A B hA t
  rw [add_mul, add_mul, hcommA]
  have e2 : exp (t • A) * (B * exp (t • B))
      = (B + t • (A * B - B * A)) * (exp (t • A) * exp (t • B)) := by
    rw [← mul_assoc, hadj, mul_assoc]
  rw [e2, mul_assoc A, add_mul]
  abel

/-- Derivative of the **symmetric-ordered curve**
`s ↦ exp (s•(A+B)) · exp ((s²/2)•C)`.  When `C = A·B − B·A` is central it
satisfies the *same* linear ODE `y'(t) = (A + B + t•C) · y(t)`. -/
theorem hasDerivAt_symCurve (A B : 𝔸)
    (hA : Commute A (A * B - B * A)) (hB : Commute B (A * B - B * A)) (t : ℝ) :
    HasDerivAt (fun s : ℝ => exp (s • (A + B)) * exp ((s ^ 2 / 2 : ℝ) • (A * B - B * A)))
      ((A + B + t • (A * B - B * A)) *
        (exp (t • (A + B)) * exp ((t ^ 2 / 2 : ℝ) • (A * B - B * A)))) t := by
  set C := A * B - B * A with hC
  set D := A + B with hD
  have hDC : Commute D C := hA.add_left hB
  have hdP : HasDerivAt (fun s : ℝ => exp (s • D)) (exp (t • D) * D) t :=
    hasDerivAt_exp_smul_const D t
  have hφ : HasDerivAt (fun s : ℝ => s ^ 2 / 2) t t := by
    simpa using (hasDerivAt_pow 2 t).div_const 2
  have hdEC : HasDerivAt (fun u : ℝ => exp (u • C)) (exp ((t ^ 2 / 2 : ℝ) • C) * C) (t ^ 2 / 2) :=
    hasDerivAt_exp_smul_const C (t ^ 2 / 2)
  have hdQ : HasDerivAt (fun s : ℝ => exp ((s ^ 2 / 2 : ℝ) • C))
      (t • (exp ((t ^ 2 / 2 : ℝ) • C) * C)) t := by
    have := hdEC.scomp t hφ
    simpa [Function.comp] using this
  have hmul := hdP.mul hdQ
  convert hmul using 1
  have hcommPD : exp (t • D) * D = D * exp (t • D) :=
    ((Commute.refl D).smul_left t).exp_left.eq
  have hCP : Commute C (exp (t • D)) := (hDC.symm.smul_right t).exp_right
  have hCQ : Commute C (exp ((t ^ 2 / 2 : ℝ) • C)) :=
    ((Commute.refl C).smul_right (t ^ 2 / 2)).exp_right
  rw [add_mul]
  have e1 : exp (t • D) * D * exp ((t ^ 2 / 2 : ℝ) • C)
      = D * (exp (t • D) * exp ((t ^ 2 / 2 : ℝ) • C)) := by
    rw [hcommPD, mul_assoc]
  have e2 : exp (t • D) * (t • (exp ((t ^ 2 / 2 : ℝ) • C) * C))
      = (t • C) * (exp (t • D) * exp ((t ^ 2 / 2 : ℝ) • C)) := by
    rw [mul_smul_comm, smul_mul_assoc]
    congr 1
    rw [← mul_assoc]
    exact (hCP.mul_right hCQ).eq.symm
  rw [e1, e2]

/-- **Central Baker–Campbell–Hausdorff identity (normal vs. symmetric ordering).**
If the commutator `C = A·B − B·A` is central (commutes with both `A` and `B`),
then
```
exp A · exp B = exp (A + B) · exp (½•C).
```
The normal-ordered product `exp A · exp B` equals the symmetric-ordered
exponential `exp (A + B)` times the central correction factor `exp (½•C)`. -/
theorem exp_mul_exp_central (A B : 𝔸)
    (hA : Commute A (A * B - B * A)) (hB : Commute B (A * B - B * A)) :
    exp A * exp B = exp (A + B) * exp ((1 / 2 : ℝ) • (A * B - B * A)) := by
  set C := A * B - B * A with hC
  set f : ℝ → 𝔸 := fun s => exp (s • A) * exp (s • B) with hf_def
  set g : ℝ → 𝔸 := fun s => exp (s • (A + B)) * exp ((s ^ 2 / 2 : ℝ) • C) with hg_def
  set v : ℝ → 𝔸 → 𝔸 := fun t y => (A + B + t • C) * y with hv_def
  have hf' : ∀ t : ℝ, HasDerivAt f (v t (f t)) t := fun t => hasDerivAt_normalCurve A B hA t
  have hg' : ∀ t : ℝ, HasDerivAt g (v t (g t)) t := fun t => hasDerivAt_symCurve A B hA hB t
  set K : NNReal := ⟨‖A + B‖ + ‖C‖, by positivity⟩ with hK_def
  have hlip : ∀ t ∈ Set.Ico (0:ℝ) 1, LipschitzOnWith K (v t) Set.univ := by
    intro t ht
    rw [lipschitzOnWith_univ, lipschitzWith_iff_norm_sub_le]
    intro x y
    have hvsub : v t x - v t y = (A + B + t • C) * (x - y) := by simp [hv_def, mul_sub]
    rw [hvsub]
    calc ‖(A + B + t • C) * (x - y)‖ ≤ ‖A + B + t • C‖ * ‖x - y‖ := norm_mul_le _ _
      _ ≤ (K : ℝ) * ‖x - y‖ := by
          apply mul_le_mul_of_nonneg_right _ (norm_nonneg _)
          have h1 : ‖A + B + t • C‖ ≤ ‖A + B‖ + ‖t • C‖ := norm_add_le _ _
          have h2 : ‖t • C‖ ≤ ‖C‖ := by
            rw [norm_smul]
            have ht1 : ‖t‖ ≤ 1 := by
              rw [Real.norm_eq_abs, abs_le]
              constructor <;> [linarith [ht.1]; linarith [ht.2.le]]
            calc ‖t‖ * ‖C‖ ≤ 1 * ‖C‖ := mul_le_mul_of_nonneg_right ht1 (norm_nonneg _)
              _ = ‖C‖ := one_mul _
          simp only [hK_def, NNReal.coe_mk]; linarith
  have hcontf : ContinuousOn f (Set.Icc 0 1) :=
    (show Differentiable ℝ f from fun t => (hf' t).differentiableAt).continuous.continuousOn
  have hcontg : ContinuousOn g (Set.Icc 0 1) :=
    (show Differentiable ℝ g from fun t => (hg' t).differentiableAt).continuous.continuousOn
  have h0 : f 0 = g 0 := by simp [hf_def, hg_def]
  have hEq : Set.EqOn f g (Set.Icc 0 1) :=
    ODE_solution_unique_of_mem_Icc_right (s := fun _ => Set.univ) hlip
      hcontf (fun t _ => (hf' t).hasDerivWithinAt) (fun _ _ => Set.mem_univ _)
      hcontg (fun t _ => (hg' t).hasDerivWithinAt) (fun _ _ => Set.mem_univ _) h0
  have h1 := hEq (Set.right_mem_Icc.mpr (by norm_num) : (1:ℝ) ∈ Set.Icc (0:ℝ) 1)
  simp only [hf_def, hg_def] at h1
  norm_num at h1
  convert h1 using 3

/-- **Symmetric exponential from the normal-ordered product.**  Rearranging the
central BCH identity, the symmetric-ordered exponential is recovered by dividing
out the central correction:
```
exp (A + B) = exp A · exp B · exp (−½•C).
``` -/
theorem exp_add_central (A B : 𝔸)
    (hA : Commute A (A * B - B * A)) (hB : Commute B (A * B - B * A)) :
    exp (A + B) = exp A * exp B * exp (-((1 / 2 : ℝ) • (A * B - B * A))) := by
  haveI hQ : NormedAlgebra ℚ 𝔸 := NormedAlgebra.restrictScalars ℚ ℝ 𝔸
  set C := (1 / 2 : ℝ) • (A * B - B * A) with hC
  have hinv : exp C * exp (-C) = 1 := by
    rw [← exp_add_of_commute ((Commute.refl C).neg_right), add_neg_cancel, exp_zero]
  rw [exp_mul_exp_central A B hA hB, ← hC, mul_assoc, hinv, mul_one]

/-- **Nilpotent (Heisenberg-type) correction factor.**  When the central
commutator is square-zero (`C^2 = 0`, the Heisenberg group / strictly-upper-
triangular case), the BCH correction factor is the affine element `1 + ½•C`:
```
exp A · exp B = exp (A + B) · (1 + ½•C).
```
So already for a nonzero nilpotent commutator the normal-ordered product differs
from the symmetric exponential by the nontrivial factor `1 + ½•C`. -/
theorem symmetric_ordering_correction_of_sq_zero (A B : 𝔸)
    (hA : Commute A (A * B - B * A)) (hB : Commute B (A * B - B * A))
    (hsq : (A * B - B * A) ^ 2 = 0) :
    exp A * exp B = exp (A + B) * (1 + (1 / 2 : ℝ) • (A * B - B * A)) := by
  have hsq2 : ((1 / 2 : ℝ) • (A * B - B * A)) ^ 2 = 0 := by
    rw [smul_pow, hsq, smul_zero]
  rw [exp_mul_exp_central A B hA hB, exp_of_sq_eq_zero _ hsq2]

end BookProof.QuadraticOrdering
