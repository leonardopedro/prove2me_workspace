import Mathlib

/-!
# Chapter "Free field parametrization in Classical Statistical Field Theory and
Navier–Stokes equations" — the *Holomorphic fields* Cauchy–Riemann remark

This file formalizes the self-contained mathematical claim of the section
*"Holomorphic fields"* (`book.tex` line ~4105), where the Hamiltonian of the
field theory is *defined by the Cauchy–Riemann equations*:

> *"Note that if a complex function of complex variable is locally integrable in
> an open domain, and satisfies the Cauchy–Riemann equations weakly, then the
> function agrees almost everywhere with an analytic function in such open
> domain."*

The book's phrasing is the *distributional* (Weyl-lemma) version: a merely
locally-integrable function whose Cauchy–Riemann equations hold in the weak
(distributional) sense is a.e. equal to a holomorphic function. That
distribution-theoretic elliptic-regularity statement is not available in
Mathlib. What *is* available — and what we formalize here — is the classical
(strong / pointwise-derivative) core that the book's remark rests on:

> **A complex function that is (real-)differentiable on an open domain and
> satisfies the Cauchy–Riemann equations there is holomorphic, i.e. complex
> analytic, on that domain** (so it is its own analytic representative — the
> "agrees with an analytic function" conclusion holds on the nose, not just
> a.e.).

We give the statement in two equivalent shapes of the Cauchy–Riemann
condition, prove both directions, and record the full characterization:

* `cauchyRiemann_analyticOn` — **operator form**: real-differentiable on an open
  `s` with `∂f/∂y = i · ∂f/∂x` (i.e. `fderiv ℝ f z I = I • fderiv ℝ f z 1`)
  implies `AnalyticOn ℂ f s`;
* `cauchyRiemann_partial_analyticOn` — the classical **partial-derivative form**
  `u_x = v_y`, `u_y = -v_x` (with `f = u + i v`), implies `AnalyticOn ℂ f s`;
* `analyticOn_cauchyRiemann` — the converse: every function analytic on an open
  set satisfies the (operator-form) Cauchy–Riemann equations there;
* `cauchyRiemann_iff_analyticOn` — the resulting characterization: for a
  function real-differentiable on an open set, holding the Cauchy–Riemann
  equations everywhere is *equivalent* to being holomorphic there;
* `cauchyRiemann_contDiffOn` — the field-theoretic payoff used implicitly by the
  book: such a function is automatically `C^∞`.

All results are `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).

The Mathlib backbone is `differentiableAt_complex_iff_differentiableAt_real`
(the Cauchy–Riemann criterion) together with Goursat's theorem in the form
`DifferentiableOn.analyticOn` (complex differentiability on an open set implies
analyticity).
-/

namespace BookProof.ChapterHolomorphic

open Complex

/-- **Cauchy–Riemann ⇒ holomorphic (operator form).**
If `f : ℂ → ℂ` is real-differentiable at every point of an open set `s` and its
real Fréchet derivative satisfies the Cauchy–Riemann equation
`∂f/∂y = i · ∂f/∂x`, i.e. `fderiv ℝ f z I = I • fderiv ℝ f z 1`, then `f` is
complex analytic on `s`. This is the classical (strong-derivative) core of the
book's "Holomorphic fields" remark. -/
theorem cauchyRiemann_analyticOn {f : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hf : ∀ z ∈ s, DifferentiableAt ℝ f z)
    (hCR : ∀ z ∈ s, fderiv ℝ f z Complex.I = Complex.I • fderiv ℝ f z 1) :
    AnalyticOn ℂ f s := by
  have hd : DifferentiableOn ℂ f s := fun z hz =>
    ((differentiableAt_complex_iff_differentiableAt_real).mpr
      ⟨hf z hz, hCR z hz⟩).differentiableWithinAt
  exact hd.analyticOn hs

/-- **Cauchy–Riemann ⇒ holomorphic (classical partial-derivative form).**
Writing `f = u + i v`, the operator-form Cauchy–Riemann equation is the pair
`u_x = v_y` and `u_y = -v_x`, where `∂f/∂x = fderiv ℝ f z 1` has real part `u_x`
and imaginary part `v_x`, and `∂f/∂y = fderiv ℝ f z I` has real part `u_y` and
imaginary part `v_y`. Under those two scalar equations (and real
differentiability), `f` is complex analytic on the open set `s`. -/
theorem cauchyRiemann_partial_analyticOn {f : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hf : ∀ z ∈ s, DifferentiableAt ℝ f z)
    (hCR1 : ∀ z ∈ s, (fderiv ℝ f z 1).re = (fderiv ℝ f z Complex.I).im)
    (hCR2 : ∀ z ∈ s, (fderiv ℝ f z 1).im = -(fderiv ℝ f z Complex.I).re) :
    AnalyticOn ℂ f s := by
  have hCR : ∀ z ∈ s, fderiv ℝ f z Complex.I = Complex.I • fderiv ℝ f z 1 := by
    intro z hz
    apply Complex.ext
    · simp only [smul_eq_mul, Complex.mul_re, Complex.I_re, Complex.I_im, zero_mul,
        one_mul, zero_sub]
      rw [hCR2 z hz]; ring
    · simp only [smul_eq_mul, Complex.mul_im, Complex.I_re, Complex.I_im, zero_mul,
        one_mul, zero_add]
      rw [hCR1 z hz]
  exact cauchyRiemann_analyticOn hs hf hCR

/-- **Holomorphic ⇒ Cauchy–Riemann (operator form).**
Every function analytic on an open set is real-differentiable there and its real
derivative satisfies the Cauchy–Riemann equation `∂f/∂y = i · ∂f/∂x`. -/
theorem analyticOn_cauchyRiemann {f : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hf : AnalyticOn ℂ f s) :
    ∀ z ∈ s, fderiv ℝ f z Complex.I = Complex.I • fderiv ℝ f z 1 := by
  intro z hz
  have hda : DifferentiableAt ℂ f z :=
    (hf.differentiableOn z hz).differentiableAt (hs.mem_nhds hz)
  exact ((differentiableAt_complex_iff_differentiableAt_real).mp hda).2

/-- **Characterization.** For a function that is real-differentiable on an open
set `s`, satisfying the Cauchy–Riemann equations at every point of `s` is
equivalent to being complex analytic (holomorphic) on `s`. -/
theorem cauchyRiemann_iff_analyticOn {f : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hf : ∀ z ∈ s, DifferentiableAt ℝ f z) :
    (∀ z ∈ s, fderiv ℝ f z Complex.I = Complex.I • fderiv ℝ f z 1) ↔
      AnalyticOn ℂ f s :=
  ⟨fun hCR => cauchyRiemann_analyticOn hs hf hCR,
   fun hA => analyticOn_cauchyRiemann hs hA⟩

/-- **Smoothness payoff.** A function that is real-differentiable and satisfies
the Cauchy–Riemann equations on an open set is automatically `C^∞` there — the
regularity the field-theoretic construction of the book relies on. -/
theorem cauchyRiemann_contDiffOn {f : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hf : ∀ z ∈ s, DifferentiableAt ℝ f z)
    (hCR : ∀ z ∈ s, fderiv ℝ f z Complex.I = Complex.I • fderiv ℝ f z 1) :
    ContDiffOn ℂ (⊤ : ℕ∞) f s :=
  ((cauchyRiemann_analyticOn hs hf hCR).contDiffOn hs.uniqueDiffOn)

end BookProof.ChapterHolomorphic
