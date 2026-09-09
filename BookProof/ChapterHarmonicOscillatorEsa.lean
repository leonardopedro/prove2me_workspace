import Mathlib
import BookProof.ChapterStrichartzHermiteQG

/-!
# The harmonic oscillator: a differential operator with an unbounded polynomial potential

`BookProof.ChapterWaveUnboundedPotential` settles the two *commuting* halves of the
"unbounded potential" problem on the Schwartz core of `L²`: an arbitrary real potential of
temperate growth is essentially self-adjoint, and so is an arbitrary real Fourier multiplier.
What those results do not reach is the genuine mixture — a differential kinetic term *plus* a
non-constant unbounded potential, which do not commute.

This module proves the prototypical mixed case, where an explicit joint eigenbasis exists:

> the harmonic oscillator `H = -d²/dx² + x²/4` is essentially self-adjoint on the Hermite
> core of `L²(ℝ)`,

with `x²/4` an unbounded polynomial potential.  The ingredients are already in the project:

* `BookProof.ChapterHermiteFunctions` constructs the Hermite orthonormal basis `hermiteLp` of
  `L²(ℝ)` and proves the eigenvalue equation `hermiteFun_oscillator`,
  `-ψ_n'' + (x²/4) ψ_n = (n + ½) ψ_n`, for the *real* Hermite functions;
* `BookProof.ChapterStrichartzHermiteQG` proves that a diagonal operator with an arbitrary
  real symbol on the Hermite core is symmetric, has trivial deficiency at every non-real
  point, and hence is essentially self-adjoint (`hermiteCoreOp_essentiallySelfAdjoint`).

What is added here is the *identification*: the diagonal operator with symbol `n + ½` really
is the differential operator `-d²/dx² + x²/4` — `harmonicOscOp_apply_eq_differential` states
that its value on the `n`-th basis vector is the `L²` class of
`x ↦ -(ψ_n)''(x) + (x²/4) ψ_n(x)`, computed with Mathlib's `deriv`.  The conclusions are
`harmonicOsc_essentiallySelfAdjoint` and `harmonicOscOp_not_bounded`: the operator is
essentially self-adjoint on the core, and genuinely unbounded.

This is the elliptic (Sears-class) prototype of the target of `CONSOLIDATED_PLAN.md` §9.5;
the hyperbolic case still needs the fibrewise argument recorded there.
-/

namespace BookProof.HarmonicOscillator

open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

/-! ## Derivatives of the complexified Hermite functions -/

/-- The complexification of "polynomial times half Gaussian". -/
noncomputable def polyGaussC (p : Polynomial ℝ) : ℝ → ℂ :=
  fun x => ((p.eval x * gaussH x : ℝ) : ℂ)

lemma hasDerivAt_polyGaussC (p : Polynomial ℝ) (x : ℝ) :
    HasDerivAt (polyGaussC p)
      ((((derivative p - C (1 / 2 : ℝ) * (X * p)).eval x * gaussH x : ℝ) : ℂ)) x :=
  (hasDerivAt_poly_mul_gaussH p x).ofReal_comp

lemma deriv_polyGaussC (p : Polynomial ℝ) :
    deriv (polyGaussC p) = polyGaussC (derivative p - C (1 / 2 : ℝ) * (X * p)) :=
  funext fun x => (hasDerivAt_polyGaussC p x).deriv

/-- The complexified Hermite function, before normalization. -/
lemma hermiteC_eq (n : ℕ) :
    hermiteC n = fun x => ((hermiteNorm n : ℝ) : ℂ)⁻¹ * polyGaussC (hermiteR n) x := by
  funext x
  simp only [hermiteC, hermiteFun, polyGaussC]
  push_cast
  ring

lemma deriv_const_mul_fun (c : ℂ) {f : ℝ → ℂ} (hf : ∀ x, DifferentiableAt ℝ f x) :
    deriv (fun x => c * f x) = fun x => c * deriv f x :=
  funext fun x => deriv_const_mul c (hf x)

/-- The second derivative of the complexified Hermite function, in terms of the real one. -/
lemma deriv_deriv_hermiteC (n : ℕ) (x : ℝ) :
    deriv (deriv (hermiteC n)) x
      = ((hermiteNorm n : ℝ) : ℂ)⁻¹ * ((deriv (deriv (hermiteFun n)) x : ℝ) : ℂ) := by
  have hdiff : ∀ (p : Polynomial ℝ) (y : ℝ), DifferentiableAt ℝ (polyGaussC p) y :=
    fun p y => (hasDerivAt_polyGaussC p y).differentiableAt
  have h1 : deriv (hermiteC n)
      = fun y => ((hermiteNorm n : ℝ) : ℂ)⁻¹ *
        polyGaussC (derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n)) y := by
    rw [hermiteC_eq n, deriv_const_mul_fun _ (hdiff (hermiteR n)), deriv_polyGaussC]
  rw [h1, deriv_const_mul_fun _ (hdiff _), deriv_polyGaussC]
  have hreal : deriv (deriv (hermiteFun n)) x
      = (derivative (derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n))
          - C (1 / 2 : ℝ) * (X * (derivative (hermiteR n)
            - C (1 / 2 : ℝ) * (X * hermiteR n)))).eval x * gaussH x := by
    have h2 : deriv (hermiteFun n)
        = fun y : ℝ => (derivative (hermiteR n) - C (1 / 2 : ℝ) * (X * hermiteR n)).eval y
            * gaussH y := by
      have : hermiteFun n = fun y : ℝ => (hermiteR n).eval y * gaussH y := rfl
      rw [this, deriv_poly_mul_gaussH]
    rw [h2, deriv_poly_mul_gaussH]
  rw [hreal]
  simp [polyGaussC]

/-- **The eigenvalue equation for the complexified Hermite functions**:
`-ψ_n'' + (x²/4) ψ_n = (n + ½) ψ_n`. -/
theorem hermiteC_oscillator (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x
      = (((n : ℝ) + 1 / 2 : ℝ) : ℂ) * hermiteC n x := by
  have hreal := hermiteFun_oscillator n x
  have hcx : hermiteC n x = ((hermiteNorm n : ℝ) : ℂ)⁻¹ * ((hermiteFun n x : ℝ) : ℂ) := by
    rw [hermiteC_eq n]
    simp [polyGaussC, hermiteFun]
  rw [deriv_deriv_hermiteC n x, hcx]
  have : ((-(deriv (deriv (hermiteFun n)) x) + x ^ 2 / 4 * hermiteFun n x : ℝ) : ℂ)
      = (((((n : ℝ) + 1 / 2) * hermiteFun n x : ℝ)) : ℂ) := by
    rw [hreal]
  push_cast at this ⊢
  linear_combination ((hermiteNorm n : ℝ) : ℂ)⁻¹ * this

/-! ## The harmonic oscillator on the Hermite core -/

/-- The symbol of the harmonic oscillator: the eigenvalues `n + ½`. -/
noncomputable def harmonicSymbol : ℕ → ℝ := fun n => (n : ℝ) + 1 / 2

/-- **The harmonic oscillator `-d²/dx² + x²/4` on the Hermite core of `L²(ℝ)`**, defined as
the diagonal operator with the eigenvalues `n + ½`; the identification with the differential
expression is `harmonicOscOp_apply_eq_differential`. -/
noncomputable def harmonicOscOp : hermiteCore →ₗ[ℂ] L2R := hermiteCoreOp harmonicSymbol

theorem harmonicOscOp_hermiteLp (n : ℕ) :
    harmonicOscOp ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = ((harmonicSymbol n : ℂ)) • hermiteLp n :=
  hermiteCoreOp_hermiteLp harmonicSymbol n

/-- The differential expression `-ψ'' + (x²/4) ψ` applied to the `n`-th Hermite function is
in `L²`. -/
theorem memLp_harmonicDifferential (n : ℕ) :
    MemLp (fun x : ℝ => -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x)
      2 (volume : Measure ℝ) := by
  have h : (fun x : ℝ => -(deriv (deriv (hermiteC n)) x) + ((x ^ 2 / 4 : ℝ) : ℂ) * hermiteC n x)
      = fun x : ℝ => (((n : ℝ) + 1 / 2 : ℝ) : ℂ) * hermiteC n x := by
    funext x
    exact hermiteC_oscillator n x
  rw [h]
  exact (memLp_hermiteC n).const_mul _

/-- **The diagonal operator is the differential operator.**  On the `n`-th Hermite basis
vector, `harmonicOscOp` returns exactly the `L²` class of `x ↦ -ψ_n''(x) + (x²/4) ψ_n(x)`. -/
theorem harmonicOscOp_apply_eq_differential (n : ℕ) :
    harmonicOscOp ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = (memLp_harmonicDifferential n).toLp _ := by
  rw [harmonicOscOp_hermiteLp]
  refine MeasureTheory.Lp.ext ?_
  filter_upwards [(memLp_harmonicDifferential n).coeFn_toLp, hermiteLp_coeFn n,
    Lp.coeFn_smul ((harmonicSymbol n : ℂ)) (hermiteLp n)] with x h1 h2 h3
  rw [h1, h3]
  simp only [Pi.smul_apply, smul_eq_mul, h2, hermiteC_oscillator n x, harmonicSymbol]

/-- The harmonic oscillator is symmetric on the Hermite core. -/
theorem harmonicOsc_symmetric : SymmetricOn hermiteCore harmonicOscOp :=
  hermiteCoreOp_symmetric harmonicSymbol

/-- **Essential self-adjointness of the harmonic oscillator** `-d²/dx² + x²/4` on the
Hermite core of `L²(ℝ)`: a differential operator whose potential is an unbounded polynomial,
and whose kinetic and potential terms do not commute. -/
theorem harmonicOsc_essentiallySelfAdjoint :
    EssentiallySelfAdjointOn hermiteCore harmonicOscOp :=
  hermiteCoreOp_essentiallySelfAdjoint harmonicSymbol

/-- The operator is genuinely unbounded. -/
theorem harmonicOsc_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore, ‖harmonicOscOp f‖ ≤ C * ‖(f : L2R)‖ := by
  refine hermiteCoreOp_not_bounded harmonicSymbol fun C => ?_
  obtain ⟨n, hn⟩ := exists_nat_gt C
  refine ⟨n, ?_⟩
  have h : |harmonicSymbol n| = (n : ℝ) + 1 / 2 := by
    rw [harmonicSymbol, abs_of_nonneg (by positivity)]
  rw [h]
  linarith

end BookProof.HarmonicOscillator
