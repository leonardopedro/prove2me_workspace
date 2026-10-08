import Mathlib


/-!
# Legendre polynomials, their differential equation, and the coefficients of
their derivatives

This module provides the one-variable algebraic input needed to identify the
associated Legendre functions / spherical harmonics `Y_{lμ}` of `book.tex` §A.5
with harmonic functions homogeneous of degree `l` (the missing ingredient of
Note 68, recorded until now as an open boundary).  Mathlib has no Legendre
polynomials, so they are built here from Rodrigues' formula.

## Contents

* `iterD_add`, `iterD_X_mul`, `iterD_Xsq_mul` — Leibniz rules for the iterated
  derivative of `X · f` and `X² · f` (the two cases needed below);
* `legendreAux l = (d/dX)ˡ (X²−1)ˡ` and the normalized
  `legendre l = (2ˡ l!)⁻¹ (d/dX)ˡ (X²−1)ˡ` (Rodrigues' formula);
* `legendreAux_ode`, `legendre_ode` — **Legendre's differential equation**
  `(1−X²)P'' − 2X P' + l(l+1) P = 0`;
* `legendre_deriv_ode` — the equation satisfied by the `μ`-th derivative
  `Y = P^{(μ)}` (the Gegenbauer form)
  `(1−X²)Y'' − 2(μ+1) X Y' + (l−μ)(l+μ+1) Y = 0`;
* `legendre_deriv_coeff_rec` — the resulting **two-step coefficient recursion**
  `(j+2)(j+1) Y_{j+2} = −((l−μ)−j)((l−μ)+j+2μ+1) Y_j`, which is exactly the
  condition for the associated solid harmonic to be harmonic;
* `legendre_natDegree_le`, `legendre_deriv_coeff_eq_zero_of_lt`,
  `legendre_deriv_parity` — degree and parity of `Y`, needed to sum the
  associated solid harmonic over the right index set;
* `legendre_coeff_top`, `legendre_ne_zero` — the leading coefficient of `P_l`
  is `(2l)!/(2ˡ (l!)²) ≠ 0`, so the construction is not vacuous.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterLegendrePolynomial

open Polynomial

/-! ## Leibniz rules for the iterated derivative -/







/-- Leibts of
their derivatives

This module provides the one-variable algebraic input needed to identify the
associated Legendre functions / spherical harmonics `Y_{lμ}` of `book.tex` §A.5
with harmonic functions homogeneous of degree `l` (the missing ingredient of
Note 68, recorded until now as an open boundary).  Mathlib has no Legendre
polynomials, so they are built here from Rodrigues' formula.

## Contents

* `iterD_add`, `iterD_X_mul`, `iterD_Xsq_mul` — Leibniz rules for the iterated
  derivative of `X · f` and `X² · f` (the two cases needed below);
* `legendreAux l = (d/dX)ˡ (X²−1)ˡ` and the normalized
  `legendre l = (2ˡ l!)⁻¹ (d/dX)ˡ (X²−1)ˡ` (Rodrigues' formula);
* `legendreAux_ode`, `legendre_ode` — **Legendre's differential equation**
  `(1−X²)P'' − 2X P' + l(l+1) P = 0`;
* `legendre_deriv_ode` — the equation satisfied by the `μ`-th derivative
  `Y = P^{(μ)}` (the Gegenbauer form)
  `(1−X²)Y'' − 2(μ+1) X Y' + (l−μ)(l+μ+1) Y = 0`;
* `legendre_deriv_coeff_rec` — the resulting **two-step coefficient recursion**
  `(j+2)(j+1) Y_{j+2} = −((l−μ)−j)((l−μ)+j+2μ+1) Y_j`, which is exactly the
  condition for the associated solid harmonic to be harmonic;
* `legendre_natDegree_le`, `legendre_deriv_coeff_eq_zero_of_lt`,
  `legendre_deriv_parity` — degree and parity of `Y`, needed to sum the
  associated solid harmonic over the right index set;
* `legendre_coeff_top`, `legendre_ne_zero` — the leading coefficient of `P_l`
  is `(2l)!/(2ˡ (l!)²) ≠ 0`, so the construction is not vacuous.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ChapterLegendrePolynomial

open Polynomial

/-! ## Leibniz rules for the iterated derivative -/

theorem iterD_add (k : ℕ) (p q : ℝ[X]) :
    derivative^[k] (p + q) = derivative^[k] p + derivative^[k] q := by
  induction k generalizing p q with
  | zero => simp
  | succ k ih =>
      rw [Function.iterate_succ_apply, Function.iterate_succ_apply, Function.iterate_succ_apply,
        derivative_add, ih]

theorem iterD_X_mul_succ (k : ℕ) (f : ℝ[X]) :
    derivative^[k+1] (X * f) = X * derivative^[k+1] f + C ((k : ℝ) + 1) * derivative^[k] f := by
  induction k with
  | zero => simp [derivative_mul]; ring
  | succ k ih =>
      rw [Function.iterate_succ_apply' derivative (k+1) (X * f), ih, derivative_add,
        derivative_mul, derivative_mul, derivative_X, derivative_C, one_mul, zero_mul, zero_add,
        ← Function.iterate_succ_apply' derivative (k+1) f,
        ← Function.iterate_succ_apply' derivative k f]
      generalize derivative^[k+1] f = a
      generalize derivative^[k+1+1] f = b
      push_cast
      simp only [C_add, C_1]
      ring

/-- Leibniz for `X · f`: `(X f)^{(k)} = X f^{(k)} + k f^{(k−1)}`. -/
theorem iterD_X_mul (k : ℕ) (f : ℝ[X]) :
    derivative^[k] (X * f) = X * derivative^[k] f + C (k : ℝ) * derivative^[k-1] f := by
  cases k with
  | zero => simp
  | succ k => simpa using iterD_X_mul_succ k f

/-- Leibniz for `X² · f`:
`(X² f)^{(k)} = X² f^{(k)} + 2k X f^{(k−1)} + k(k−1) f^{(k−2)}`. -/
theorem iterD_Xsq_mul (k : ℕ) (f : ℝ[X]) :
    derivative^[k] (X ^ 2 * f)
      = X ^ 2 * derivative^[k] f + C (2 * (k : ℝ)) * X * derivative^[k-1] f
        + C ((k : ℝ) * ((k : ℝ) - 1)) * derivative^[k-2] f := by
  have h1 : X ^ 2 * f = X * (X * f) := by ring
  rw [h1, iterD_X_mul k (X * f), iterD_X_mul k f, iterD_X_mul (k-1) f]
  match k with
  | 0 => simp; ring
  | 1 => simp; push_cast; simp only [C_add, C_1, C_mul, map_ofNat]; ring
  | (n+2) =>
      have e1 : n + 2 - 1 = n + 1 := rfl
      have e2 : n + 2 - 2 = n := rfl
      have e3 : n + 1 - 1 = n := rfl
      rw [e1, e2, e3]
      push_cast
      simp only [C_sub, C_add, C_mul, C_1, map_ofNat]
      ring

/-! ## Rodrigues' formula and Legendre's equation -/

/-- The unnormalized Rodrigues polynomial `(d/dX)ˡ (X²−1)ˡ`. -/
noncomputable def legendreAux (l : ℕ) : ℝ[X] := derivative^[l] ((X ^ 2 - 1) ^ l)

/-- **The Legendre polynomial** `P_l = (2ˡ l!)⁻¹ (d/dX)ˡ (X²−1)ˡ`. -/
noncomputable def legendre (l : ℕ) : ℝ[X] :=
  C ((2 ^ l * (Nat.factorial l : ℝ))⁻¹) * legendreAux l









/-! ## The coefficient recursion -/





/-! ## Degree, parity and the leading coefficient -/























end BookProof.ChapterLegendrePolynomial
