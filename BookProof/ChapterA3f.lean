import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3e

/-!
# Chapter A.3 (f): `det (exp A) = exp (tr A)` and the unit determinant of `Spin⁺(3,1)`

This module discharges the analytic ingredient recorded as the standing
obstruction for the **group-level** part of Note 47 / Lemma 48 of §A.3
(work-package **N4**): the determinant identity

`det (exp A) = exp (tr A)`   (Jacobi–Liouville formula)

for a real square matrix `A`, listed as a `TODO` in Mathlib
(`Mathlib/Analysis/Normed/Algebra/MatrixExponential.lean`, line 57).

The proof is the classical one-parameter-group / ODE argument.  Set
`f t := det (exp (t • A))`.  Then

* `f 0 = 1`;
* `f (s + t) = f s * f t` (one-parameter group, from
  `NormedSpace.exp_add_of_commute` + `Matrix.det_mul`);
* `HasDerivAt f (A.trace) 0` (Jacobi's formula at the identity, from
  `Matrix.det_one_add_smul` and differentiability of `det`);
* hence `HasDerivAt f (A.trace * f t) t` for every `t` (group property);
* so `t ↦ f t * exp (-(A.trace * t))` has zero derivative, is constant `= 1`,
  giving `f t = exp (A.trace * t)`; evaluate at `t = 1`.

As the headline downstream consequence we obtain
`spinLie_det_exp_eq_one`: every element of the spin Lie algebra `𝔰𝔭𝔦𝔫⁺(3,1)`
(traceless, `ChapterA3e.spinLie_traceless`) exponentiates to a matrix of unit
determinant — the infinitesimal-to-group `det = 1` half of Lemma 48.
-/

open Matrix NormedSpace
open scoped Norms.Operator

namespace BookProof.ChapterA3

variable {n : ℕ}

/-- The one-parameter determinant function `f t = det (exp (t • A))`. -/
noncomputable def detExpPath (A : Matrix (Fin n) (Fin n) ℝ) (t : ℝ) : ℝ :=
    (NormedSpace.exp (t • A)).det

@[simp] theorem detExpPath_zero (A : Matrix (Fin n) (Fin n) ℝ) :
    detExpPath A 0 = 1 := by
  simp [detExpPath]

/-
The one-parameter group property: `f (s + t) = f s * f t`.
-/
theorem detExpPath_add (A : Matrix (Fin n) (Fin n) ℝ) (s t : ℝ) :
    detExpPath A (s + t) = detExpPath A s * detExpPath A t := by
  have h_comm : Commute (s • A) (t • A) := by
    exact Commute.smul_left ( Commute.smul_right ( Commute.refl _ ) _ ) _;
  convert congr_arg Matrix.det ( NormedSpace.exp_add_of_commute h_comm ) using 1;
  · unfold detExpPath; norm_num [ add_smul ] ;
  · unfold detExpPath; aesop;

/-
`Matrix.det` is differentiable (it is a polynomial in the entries).
-/
theorem differentiable_det :
    Differentiable ℝ (Matrix.det : Matrix (Fin n) (Fin n) ℝ → ℝ) := by
  unfold det;
  simp only [detRowAlternating, MultilinearMap.alternatization, MultilinearMap.coe_sum,
      MultilinearMap.mkPiAlgebra, AddMonoidHom.coe_mk, ZeroHom.coe_mk, AlternatingMap.coe_mk,
          MultilinearMap.coe_mk, Finset.sum_apply, MultilinearMap.smul_apply,
              MultilinearMap.domDomCongr_apply, MultilinearMap.compLinearMap_apply,
                  LinearMap.coe_proj, Function.eval];
  fun_prop

/-
Jacobi's formula along the line `1 + t • A`: the derivative at `0` is the
trace.
-/
theorem hasDerivAt_det_line (A : Matrix (Fin n) (Fin n) ℝ) :
    HasDerivAt (fun t : ℝ => (1 + t • A).det) A.trace 0 := by
  obtain ⟨P, hP⟩ : ∃ P : Polynomial ℝ,    ∀ t : ℝ, (1 + t • A).det = 1 + A.trace * t + P.eval t * t
      ^ 2 := by
    exact ⟨ _, fun t => Matrix.det_one_add_smul t A ⟩;
  norm_num [ sq, mul_assoc, mul_comm, mul_left_comm, Polynomial.differentiableAt, hP ];
  convert HasDerivAt.add ( HasDerivAt.add ( hasDerivAt_const _ _ ) ( HasDerivAt.mul ( hasDerivAt_id
      ( 0 : ℝ ) ) ( hasDerivAt_const _ _ ) ) ) ( HasDerivAt.mul ( hasDerivAt_id ( 0 : ℝ ) ) (
          HasDerivAt.mul ( hasDerivAt_id ( 0 : ℝ ) ) ( P.hasDerivAt 0 ) ) ) using 1 ; norm_num

/-
Jacobi's formula at the identity along the exponential path:
`HasDerivAt (fun t => det (exp (t • A))) (tr A) 0`.
-/
theorem hasDerivAt_detExpPath_zero (A : Matrix (Fin n) (Fin n) ℝ) :
    HasDerivAt (detExpPath A) A.trace 0 := by
  -- The derivative of the determinant at the identity matrix is the trace of the matrix.
  have h_det_deriv : HasDerivAt (fun t : ℝ => (1 + t • A).det) (A.trace) 0 :=
    hasDerivAt_det_line A
  have h_det_deriv : HasFDerivAt (Matrix.det : Matrix (Fin n) (Fin n) ℝ → ℝ) (fderiv ℝ (Matrix.det :
      Matrix (Fin n) (Fin n) ℝ → ℝ) (1 : Matrix (Fin n) (Fin n) ℝ)) (1 : Matrix (Fin n) (Fin n) ℝ)
          := by
    apply_rules [ DifferentiableAt.hasFDerivAt, differentiable_det ];
  have h_det_deriv : HasDerivAt (fun t : ℝ => Matrix.det (1 + t • A)) (fderiv ℝ (Matrix.det : Matrix
      (Fin n) (Fin n) ℝ → ℝ) (1 : Matrix (Fin n) (Fin n) ℝ) A) 0 := by
    convert HasFDerivAt.comp_hasDerivAt _ _ _ using 1;
    · simpa using h_det_deriv;
    · simp [ hasDerivAt_iff_tendsto ];
  have h_det_deriv : fderiv ℝ (Matrix.det : Matrix (Fin n) (Fin n) ℝ → ℝ) (1 : Matrix (Fin n) (Fin
      n) ℝ) A = A.trace := by
    exact h_det_deriv.unique ‹_›;
  convert HasFDerivAt.comp_hasDerivAt _ _ _ using 1;
  any_goals exact hasDerivAt_exp_smul_const' A 0;
  focus (convert h_det_deriv.symm);
  · norm_num [ NormedSpace.exp_zero ];
  · aesop

/-
The derivative of the one-parameter determinant at an arbitrary point,
obtained from the group property and the derivative at `0`.
-/
theorem hasDerivAt_detExpPath (A : Matrix (Fin n) (Fin n) ℝ) (t : ℝ) :
    HasDerivAt (detExpPath A) (A.trace * detExpPath A t) t := by
  have h_deriv : HasDerivAt (fun h => detExpPath A (t + h)) (A.trace * detExpPath A t) 0 := by
    convert HasDerivAt.const_mul ( detExpPath A t ) ( hasDerivAt_detExpPath_zero A ) using 1;
    · exact funext fun x => detExpPath_add A t x;
    · ring;
  rw [ hasDerivAt_iff_tendsto_slope_zero ] at *;
  aesop

/-
**Jacobi–Liouville formula.**  `det (exp A) = exp (tr A)` for a real
square matrix.
-/
theorem det_exp_eq_exp_trace (A : Matrix (Fin n) (Fin n) ℝ) :
    (NormedSpace.exp A).det = Real.exp A.trace := by
  -- Define `g : ℝ → ℝ`, `g t := detExpPath A t * Real.exp (-(A.trace * t))`.
  set g : ℝ → ℝ := fun t => detExpPath A t * Real.exp (-(A.trace * t));
  -- By definition of $g$, we know that its derivative is zero everywhere.
  have hg_deriv_zero : ∀ t, HasDerivAt g 0 t := by
    intro t;
    convert HasDerivAt.mul ( hasDerivAt_detExpPath A t ) ( HasDerivAt.exp ( HasDerivAt.neg (
        HasDerivAt.const_mul ( A.trace ) ( hasDerivAt_id t ) ) ) ) using 1 ; ring;
  -- Since $g$ is differentiable and its derivative is zero everywhere, $g$ must be constant.
  have hg_const : ∀ t₁ t₂, g t₁ = g t₂ := by
    exact fun t₁ t₂ => is_const_of_deriv_eq_zero ( fun t => HasDerivAt.differentiableAt (
        hg_deriv_zero t ) ) ( fun t => HasDerivAt.deriv ( hg_deriv_zero t ) ) t₁ t₂;
  convert congr_arg ( fun x => x / Real.exp ( - ( A.trace * 1 ) ) ) ( hg_const 1 0 ) using 1 <;>
      norm_num [ Real.exp_neg ];
  · simp? +zetaDelta at *;
    unfold detExpPath; norm_num [ mul_assoc, ← Real.exp_add ] ;
  · simp +zetaDelta at *

/-- **Group-level `det = 1` of Lemma 48.**  Every element of the spin Lie
algebra `𝔰𝔭𝔦𝔫⁺(3,1)` exponentiates to a matrix of unit determinant. -/
theorem spinLie_det_exp_eq_one {G : Matrix (Fin 4) (Fin 4) ℝ} (hG : IsSpinLie G) :
    (NormedSpace.exp G).det = 1 := by
  rw [det_exp_eq_exp_trace, spinLie_traceless hG, Real.exp_zero]

end BookProof.ChapterA3
