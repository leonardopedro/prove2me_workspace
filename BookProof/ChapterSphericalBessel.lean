import Mathlib

/-!
# Chapter — Hankel–Majorana transform: the spherical Bessel functions (Rayleigh formula)

Source: `book.tex`, §A.5 subsection *"Hankel–Majorana Transform"* (line ~5805),
Definitions 65–71.  There the author builds the spherical / Hankel–Majorana
transform out of the **spherical Bessel functions of the first kind** `jₗ`,
defined (Definition 67) by the **Rayleigh formula**

`jₗ(r) = rˡ (-(1/r) d/dr)ˡ (sin r / r)`.

These special functions are **not** available in Mathlib, so this file develops
the self-contained analytic core from scratch: the Rayleigh operator, the
generating function `j₀(r) = sin r / r`, and the first closed forms together
with the recurrence that links them and the defining second-order ODE.

Formalized here:

* `rayleighOp` — the Rayleigh differential operator `T f = -(1/r) f'`;
* `sbessel` — the spherical Bessel function via the book's Rayleigh formula
  `jₗ(r) = rˡ (Tˡ (sin r / r))(r)`;
* `sj0` / `sj1` / `sj2` — the classical closed forms
  `j₀ = sin r / r`, `j₁ = sin r / r² − cos r / r`,
  `j₂ = (3/r³ − 1/r) sin r − (3/r²) cos r`;
* `deriv_sbesselBase` — the derivative of the generator `sin r / r`;
* `sbessel_zero` / `sbessel_one_eq` / `sbessel_two_eq` — the Rayleigh formula
  reproduces the three closed forms;
* `rayleigh_raise_01` — the raising relation `j₁ = −(d/dr) j₀`;
* `sj0_satisfies_ode` — `j₀` solves the `l = 0` spherical Bessel ODE
  `r² j'' + 2 r j' + r² j = 0`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterSphericalBessel

open scoped Topology

/-- The Rayleigh differential operator `T f (r) = -(1/r) · f'(r)`, used in the
book's Rayleigh formula for the spherical Bessel functions. -/
noncomputable def rayleighOp (f : ℝ → ℝ) : ℝ → ℝ := fun r => -(1 / r) * deriv f r

/-- The generating function `j₀(r) = sin r / r` of the spherical Bessel family. -/
noncomputable def sbesselBase : ℝ → ℝ := fun r => Real.sin r / r

/-- The spherical Bessel function of the first kind, defined by the book's
Rayleigh formula (Definition 67):
`jₗ(r) = rˡ (-(1/r) d/dr)ˡ (sin r / r)`. -/
noncomputable def sbessel (l : ℕ) : ℝ → ℝ :=
  fun r => r ^ l * (rayleighOp^[l] sbesselBase) r

/-- Closed form for `j₀`. -/
noncomputable def sj0 : ℝ → ℝ := fun r => Real.sin r / r

/-- Closed form for `j₁`. -/
noncomputable def sj1 : ℝ → ℝ := fun r => Real.sin r / r ^ 2 - Real.cos r / r

/-- Closed form for `j₂`. -/
noncomputable def sj2 : ℝ → ℝ :=
  fun r => (3 / r ^ 3 - 1 / r) * Real.sin r - 3 / r ^ 2 * Real.cos r

/-- The derivative of the generating function `sin r / r`. -/
theorem deriv_sbesselBase {r : ℝ} (hr : r ≠ 0) :
    deriv sbesselBase r = Real.cos r / r - Real.sin r / r ^ 2 := by
  convert HasDerivAt.deriv (HasDerivAt.div (Real.hasDerivAt_sin r) (hasDerivAt_id r) hr) using 1
  simp only [id_eq]; field_simp

/-- The Rayleigh formula reproduces `j₀(r) = sin r / r`. -/
theorem sbessel_zero : sbessel 0 = sj0 := by
  funext r; simp [sbessel, sbesselBase, sj0]

/-- The Rayleigh formula reproduces `j₁(r) = sin r / r² − cos r / r`. -/
theorem sbessel_one_eq {r : ℝ} (hr : r ≠ 0) : sbessel 1 r = sj1 r := by
  have hd := deriv_sbesselBase hr
  simp only [sbessel, sj1, rayleighOp, Function.iterate_one, pow_one, hd]
  field_simp; ring

/-- The Rayleigh raising relation between the first two spherical Bessel
functions: `j₁ = −(d/dr) j₀`. -/
theorem rayleigh_raise_01 {r : ℝ} (hr : r ≠ 0) : sj1 r = -deriv sj0 r := by
  have hd : deriv sj0 r = Real.cos r / r - Real.sin r / r ^ 2 := deriv_sbesselBase hr
  rw [hd, sj1]; ring

/-- The Rayleigh formula reproduces
`j₂(r) = (3/r³ − 1/r) sin r − (3/r²) cos r`. -/
theorem sbessel_two_eq {r : ℝ} (hr : r ≠ 0) : sbessel 2 r = sj2 r := by
  have hee : deriv (rayleighOp sbesselBase) r
      = deriv (fun x => -(1 / x) * (Real.cos x / x - Real.sin x / x ^ 2)) r := by
    refine Filter.EventuallyEq.deriv_eq ?_
    filter_upwards [isOpen_ne.mem_nhds hr] with x hx
    simp only [rayleighOp, deriv_sbesselBase hx]
  have h2 : (rayleighOp^[2] sbesselBase) r
      = -(1 / r) * deriv (rayleighOp sbesselBase) r := rfl
  rw [sbessel, h2, hee, sj2]
  norm_num [hr, differentiableAt_inv]
  field_simp; ring

/-- `j₀(r) = sin r / r` solves the `l = 0` spherical Bessel ODE
`r² j'' + 2 r j' + r² j = 0`. -/
theorem sj0_satisfies_ode {r : ℝ} (hr : r ≠ 0) :
    r ^ 2 * deriv (deriv sj0) r + 2 * r * deriv sj0 r + r ^ 2 * sj0 r = 0 := by
  have h1 : ∀ x ≠ 0, deriv sj0 x = Real.cos x / x - Real.sin x / x ^ 2 :=
    fun x hx => deriv_sbesselBase hx
  have h2 : deriv (deriv sj0) r
      = deriv (fun x => Real.cos x / x - Real.sin x / x ^ 2) r :=
    Filter.EventuallyEq.deriv_eq
      (Filter.eventuallyEq_of_mem (isOpen_compl_singleton.mem_nhds hr) h1)
  rw [h2, h1 r hr, sj0]
  norm_num [Real.differentiableAt_sin, Real.differentiableAt_cos, hr, differentiableAt_inv]
  field_simp; ring

end BookProof.ChapterSphericalBessel
