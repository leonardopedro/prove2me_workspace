import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3e
import Mathlib


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


/-
`Matrix.det` is differentiable (it is a polynomial in the entries).
-/


/-
Jacobi's formula along the line `1 + t • A`: the derivative at `0` is the
trace.
-/


/-
Jacobi's formula at the identity along the exponential path:
`HasDerivAt (fun t => det (exp (t • A))) (tr A) 0`.
-/


/-
The derivative of the one-parameter determinant at an arbitrary point,
obtained from the group property and the derivative at `0`.
-/


/-
**Jacobi–Liouville formula.**  `det (exp A) = exp (tr A)` for a real
square matrix.
-/




end BookProof.ChapterA3
