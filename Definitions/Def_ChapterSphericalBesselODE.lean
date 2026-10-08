import Definitions.Def_ChapterSphericalBessel
import Mathlib


/-!
# Chapter — Hankel–Majorana transform: the spherical Bessel equation for every `l`

Source: `book.tex`, §A.5, subsection *"Hankel–Majorana Transform"* (line ~5805),
Definitions 65–67 and **Note 68**.  The book defines the spherical transform

`𝓗_P{ψ}(p,l,μ) = ∫ r² dr d(cos θ) dφ (2p/√(2π)) jₗ(pr) Y_{lμ}(θ,φ) ψ(r,θ,φ)`

out of the spherical Bessel functions `jₗ` of `BookProof.ChapterSphericalBessel`
(the Rayleigh formula `jₗ(r) = rˡ (−(1/r) d/dr)ˡ (sin r / r)`), and states in
**Note 68** that, "due to the properties of the spherical harmonics and Bessel
functions", the inverse transform intertwines the Laplacian with multiplication
by `p²`:

`−∂⃗² 𝓗_P⁻¹{ψ} = 𝓗_P⁻¹{p² ψ}`.

The analytic heart of that statement — the only part of it that concerns the
Bessel functions themselves — is that `jₗ` solves the **spherical Bessel
equation**, equivalently that `r ↦ jₗ(p r)` is an eigenfunction, with eigenvalue
`p²`, of the radial part of `−∂⃗²` in the sector of angular momentum `l`.
`BookProof.ChapterSphericalBessel` proved this for `l = 0` only.  This module
proves it for **every** `l`, directly from the Rayleigh formula.

## Contents

* `gIter l` — the `l`-th Rayleigh iterate `(−(1/r) d/dr)ˡ (sin r / r)`, so that
  `jₗ(r) = rˡ · gIter l r`;
* `contDiffOn_gIter`, `diffAt_gIter`, `diffAt_deriv_gIter` — every iterate is
  smooth away from the origin (proved by induction, and needed to differentiate
  the iterates at all);
* `deriv_gIter_eq` — the Rayleigh step `gₗ'(r) = −r · gₗ₊₁(r)`;
* `gIter_ode` — the equation satisfied by the iterates:
  `r gₗ'' + (2l+2) gₗ' + r gₗ = 0`, proved by induction on `l`;
* `gIter_pred_eq` — the companion first-order identity
  `gₗ = (2l+3) gₗ₊₁ + r gₗ₊₁'`;
* `sbessel_ode` — **the spherical Bessel equation**
  `r² jₗ'' + 2 r jₗ' + (r² − l(l+1)) jₗ = 0` for every `l`;
* `sbessel_rayleigh_raise` — the Rayleigh raising relation
  `jₗ₊₁(r) = −rˡ · d/dr (jₗ(r)/rˡ)`;
* `sbessel_recurrence` — the three-term recurrence
  `jₗ₋₁(r) + jₗ₊₁(r) = ((2l+1)/r) jₗ(r)`;
* `sbessel_radial_eigen` — **Note 68 in the radial sector**: for `p > 0` the
  function `u(r) = jₗ(p r)` satisfies
  `−(u''(r) + (2/r) u'(r) − (l(l+1)/r²) u(r)) = p² u(r)`,
  i.e. it is an eigenfunction of the radial Laplacian with angular momentum `l`
  and eigenvalue `p²`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis.
-/

namespace BookProof.ChapterSphericalBesselODE

open BookProof.ChapterSphericalBessel

/-- The `l`-th Rayleigh iterate `gₗ = (−(1/r) d/dr)ˡ (sin r / r)`; the spherical
Bessel function is `jₗ(r) = rˡ gₗ(r)`. -/
noncomputable def gIter (l : ℕ) : ℝ → ℝ := rayleighOp^[l] sbesselBase



/-! ## Smoothness of the Rayleigh iterates away from the origin -/









/-! ## The Rayleigh step and the equation satisfied by the iterates -/







ok.tex`, §A.5, subsection *"Hankel–Majorana Transform"* (line ~5805),
Definitions 65–67 and **Note 68**.  The book defines the spherical transform

`𝓗_P{ψ}(p,l,μ) = ∫ r² dr d(cos θ) dφ (2p/√(2π)) jₗ(pr) Y_{lμ}(θ,φ) ψ(r,θ,φ)`

out of the spherical Bessel functions `jₗ` of `BookProof.ChapterSphericalBessel`
(the Rayleigh formula `jₗ(r) = rˡ (−(1/r) d/dr)ˡ (sin r / r)`), and states in
**Note 68** that, "due to the properties of the spherical harmonics and Bessel
functions", the inverse transform intertwines the Laplacian with multiplication
by `p²`:

`−∂⃗² 𝓗_P⁻¹{ψ} = 𝓗_P⁻¹{p² ψ}`.

The analytic heart of that statement — the only part of it that concerns the
Bessel functions themselves — is that `jₗ` solves the **spherical Bessel
equation**, equivalently that `r ↦ jₗ(p r)` is an eigenfunction, with eigenvalue
`p²`, of the radial part of `−∂⃗²` in the sector of angular momentum `l`.
`BookProof.ChapterSphericalBessel` proved this for `l = 0` only.  This module
proves it for **every** `l`, directly from the Rayleigh formula.

## Contents

* `gIter l` — the `l`-th Rayleigh iterate `(−(1/r) d/dr)ˡ (sin r / r)`, so that
  `jₗ(r) = rˡ · gIter l r`;
* `contDiffOn_gIter`, `diffAt_gIter`, `diffAt_deriv_gIter` — every iterate is
  smooth away from the origin (proved by induction, and needed to differentiate
  the iterates at all);
* `deriv_gIter_eq` — the Rayleigh step `gₗ'(r) = −r · gₗ₊₁(r)`;
* `gIter_ode` — the equation satisfied by the iterates:
  `r gₗ'' + (2l+2) gₗ' + r gₗ = 0`, proved by induction on `l`;
* `gIter_pred_eq` — the companion first-order identity
  `gₗ = (2l+3) gₗ₊₁ + r gₗ₊₁'`;
* `sbessel_ode` — **the spherical Bessel equation**
  `r² jₗ'' + 2 r jₗ' + (r² − l(l+1)) jₗ = 0` for every `l`;
* `sbessel_rayleigh_raise` — the Rayleigh raising relation
  `jₗ₊₁(r) = −rˡ · d/dr (jₗ(r)/rˡ)`;
* `sbessel_recurrence` — the three-term recurrence
  `jₗ₋₁(r) + jₗ₊₁(r) = ((2l+1)/r) jₗ(r)`;
* `sbessel_radial_eigen` — **Note 68 in the radial sector**: for `p > 0` the
  function `u(r) = jₗ(p r)` satisfies
  `−(u''(r) + (2/r) u'(r) − (l(l+1)/r²) u(r)) = p² u(r)`,
  i.e. it is an eigenfunction of the radial Laplacian with angular momentum `l`
  and eigenvalue `p²`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis.
-/

namespace BookProof.ChapterSphericalBesselODE

open BookProof.ChapterSphericalBessel

/-- The `l`-th Rayleigh iterate `gₗ = (−(1/r) d/dr)ˡ (sin r / r)`; the spherical
Bessel function is `jₗ(r) = rˡ gₗ(r)`. -/
noncomputable def gIter (l : ℕ) : ℝ → ℝ := rayleighOp^[l] sbesselBase

theorem sbessel_eq (l : ℕ) (r : ℝ) : sbessel l r = r ^ l * gIter l r := rfl

/-! ## Smoothness of the Rayleigh iterates away from the origin -/

theorem contDiffOn_sbesselBase : ContDiffOn ℝ (⊤ : ℕ∞) sbesselBase {r : ℝ | r ≠ 0} := by
  apply ContDiffOn.div Real.contDiff_sin.contDiffOn contDiff_id.contDiffOn
  intro x hx; exact hx

/-- Every Rayleigh iterate is smooth on the punctured line. -/
theorem contDiffOn_gIter (l : ℕ) : ContDiffOn ℝ (⊤ : ℕ∞) (gIter l) {r : ℝ | r ≠ 0} := by
  induction l with
  | zero => simpa [gIter] using contDiffOn_sbesselBase
  | succ n ih =>
      have hstep : gIter (n + 1) = rayleighOp (gIter n) := by
        simp [gIter, Function.iterate_succ_apply']
      rw [hstep]
      have hd : ContDiffOn ℝ (⊤ : ℕ∞) (deriv (gIter n)) {r : ℝ | r ≠ 0} :=
        ih.deriv_of_isOpen (m := (⊤ : ℕ∞)) isOpen_ne (by simp)
      have hinv : ContDiffOn ℝ (⊤ : ℕ∞) (fun r : ℝ => -(1 / r)) {r : ℝ | r ≠ 0} := by
        apply ContDiffOn.neg
        apply ContDiffOn.div contDiffOn_const contDiff_id.contDiffOn
        intro x hx; exact hx
      exact hinv.mul hd

theorem diffAt_gIter (l : ℕ) {r : ℝ} (hr : r ≠ 0) : DifferentiableAt ℝ (gIter l) r :=
  ((contDiffOn_gIter l).differentiableOn (by simp)).differentiableAt (isOpen_ne.mem_nhds hr)

theorem diffAt_deriv_gIter (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    DifferentiableAt ℝ (deriv (gIter l)) r :=
  (((contDiffOn_gIter l).deriv_of_isOpen (m := (⊤ : ℕ∞)) isOpen_ne (by simp)).differentiableOn
    (by simp)).differentiableAt (isOpen_ne.mem_nhds hr)

/-! ## The Rayleigh step and the equation satisfied by the iterates -/

theorem gIter_succ (l : ℕ) (r : ℝ) : gIter (l + 1) r = -(1 / r) * deriv (gIter l) r := by
  simp [gIter, Function.iterate_succ_apply', rayleighOp]

/-- The Rayleigh step, read as a formula for the derivative: `gₗ'(r) = −r gₗ₊₁(r)`. -/
theorem deriv_gIter_eq (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    deriv (gIter l) r = -r * gIter (l + 1) r := by
  rw [gIter_succ]; field_simp

theorem second_deriv_gIter (l : ℕ) {r : ℝ} (hr : r ≠ 0) :
    deriv (deriv (gIter l)) r = -gIter (l + 1) r - r * deriv (gIter (l + 1)) r := by
  have hEq : deriv (gIter l) =ᶠ[nhds r] fun x => -x * gIter (l + 1) x := by
    filter_upwards [isOpen_ne.mem_nhds hr] with x hx using deriv_gIter_eq l hx
  have hneg : HasDerivAt (fun x : ℝ => -x) (-1 : ℝ) r := by
    simpa using! (hasDerivAt_id r).neg
  have hD : HasDerivAt (fun x : ℝ => -x * gIter (l + 1) x)
      (-1 * gIter (l + 1) r + -r * deriv (gIter (l + 1)) r) r :=
    hneg.mul ((diffAt_gIter (l + 1) hr).hasDerivAt)
  rw [hEq.deriv_eq, hD.deriv]
  ring

theorem hasDerivAt_sbesselBase {x : ℝ} (hx : x ≠ 0) :
    HasDerivAt sbesselBase (Real.cos x / x - Real.sin x / x ^ 2) x := by
  have h := (Real.hasDerivAt_sin x).div (hasDerivAt_id x) hx
  simp only [id_eq] at h
  have he : (Real.cos x * x - Real.sin x * 1) / x ^ 2
      = Real.cos x / x - Real.sin x / x ^ 2 := by field_simp
  rwa [he] at h

/-- The base case `l = 0` of `gIter_ode`: `r g₀'' + 2 g₀' + r g₀ = 0` for
`g₀(r) = sin r / r`. -/
theorem gIter_ode_zero {r : ℝ} (hr : r ≠ 0) :
    r * deriv (deriv (gIter 0)) r + 2 * deriv (gIter 0) r + r * gIter 0 r = 0 := by
  have hg0 : gIter 0 = sbesselBase := rfl
  rw [hg0]
  have hEq : deriv sbesselBase =ᶠ[nhds r] fun x => Real.cos x / x - Real.sin x / x ^ 2 := by
    filter_upwards [isOpen_ne.mem_nhds hr] with x hx using (hasDerivAt_sbesselBase hx).deriv
  have h3 : HasDerivAt (fun x : ℝ => Real.cos x / x)
      ((-Real.sin r * r - Real.cos r * 1) / r ^ 2) r := by
    simpa using! (Real.hasDerivAt_cos r).div (hasDerivAt_id r) hr
  have h4 : HasDerivAt (fun x : ℝ => Real.sin x / x ^ 2)
      ((Real.cos r * r ^ 2 - Real.sin r * (2 * r)) / (r ^ 2) ^ 2) r := by
    have h : HasDerivAt (fun x : ℝ => x ^ 2) (2 * r) r := by simpa using hasDerivAt_pow 2 r
    exact (Real.hasDerivAt_sin r).div h (pow_ne_zero 2 hr)
  have h2 : HasDerivAt (fun x : ℝ => Real.cos x / x - Real.sin x / x ^ 2)
      ((-Real.sin r * r - Real.cos r * 1) / r ^ 2
        - (Real.cos r * r ^ 2 - Real.sin r * (2 * r)) / (r ^ 2) ^ 2) r := h3.sub h4
  rw [hEq.deriv_eq, h2.deriv, (hasDerivAt_sbesselBase hr).deriv, sbesselBase]
  field_simp
  ring






/-! ## The spherical Bessel equation -/









/-! ## The three-term recurrence -/



/-! ## Note 68 in the radial sector -/









end BookProof.ChapterSphericalBesselODE
