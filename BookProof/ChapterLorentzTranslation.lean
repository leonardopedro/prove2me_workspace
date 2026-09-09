import Mathlib

/-!
# Chapter — Yang–Mills / Classical Statistical Field Theory: the space-time
translation representation in the momentum-diagonal basis

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Lorentz covariance"* (line ~6506).

Working in a basis where the 3-momentum operator is diagonal, the author writes
the space-time translations of a free system of invariant mass `M` as

  `T(x) Ψ(γv) = e^{i M τ(γv, x)} Ψ(γv)`,   `τ(γv, x) = γ x₀ − (γv)·x`,

where the four-velocity is `(γ, γv)` with `γ = √(1 + (γv)²)` a function of the
spatial momentum `γv`.  The book observes that in this basis the space-time
translations "have the same structure as the time-evolution in non-relativistic
space-time, with `M` playing the role of the Hamiltonian and `τ` playing the role
of (proper) time".

This file makes that self-contained content precise.  We model the spatial
momentum `γv` by `w : Fin 3 → ℝ`, define `gamma w = √(1 + ∑ (w i)²)`, the
proper-time functional `properTime w x₀ xs = γ x₀ − ∑ wᵢ xsᵢ`, and the phase
`transPhase M w x₀ xs = e^{i M τ}`.  We prove:

* `gamma_sq` / `mass_shell` — the four-velocity is on the unit mass shell,
  `γ² − (γv)² = 1`;
* `gamma_zero` — the rest-frame value `γ = 1` at `γv = 0`;
* `properTime_add`, `properTime_zero` — `τ` is additive in the space-time
  translation `x` (a homomorphism `(ℝ⁴, +) → (ℝ, +)`);
* `properTime_rest` — in the rest frame `τ = x₀` (proper time = coordinate time);
* `transPhase_add` — **headline**: the phases compose,
  `T(x + y) = T(x) · T(y)`, so `x ↦ transPhase M w x` is a one-dimensional
  unitary representation of the space-time translation group;
* `transPhase_zero` — `T(0) = 1`;
* `transPhase_norm` — each `T(x)` is unitary (`‖·‖ = 1`, for real `M`);
* `transPhase_rest` — in the rest frame `T(x) = e^{i M x₀}`, exactly the
  non-relativistic time-evolution phase.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterLorentzTranslation

open scoped BigOperators

/-- The Lorentz factor `γ = √(1 + (γv)²)` as a function of the spatial momentum
`γv = w`; the temporal component of the (dimensionless) four-velocity `(γ, γv)`. -/
noncomputable def gamma (w : Fin 3 → ℝ) : ℝ := Real.sqrt (1 + ∑ i, (w i) ^ 2)

lemma gamma_nonneg (w : Fin 3 → ℝ) : 0 ≤ gamma w := Real.sqrt_nonneg _

/-- `γ² = 1 + (γv)²`. -/
lemma gamma_sq (w : Fin 3 → ℝ) : gamma w ^ 2 = 1 + ∑ i, (w i) ^ 2 := by
  unfold gamma; rw [Real.sq_sqrt (by positivity)]

/-- The **mass shell**: the four-velocity `(γ, γv)` satisfies `γ² − (γv)² = 1`. -/
lemma mass_shell (w : Fin 3 → ℝ) : gamma w ^ 2 - ∑ i, (w i) ^ 2 = 1 := by
  rw [gamma_sq]; ring

/-- In the rest frame `γv = 0` the Lorentz factor is `γ = 1`. -/
lemma gamma_zero : gamma (fun _ => 0) = 1 := by
  unfold gamma; simp

/-- The proper-time functional `τ(γv, x) = γ x₀ − (γv)·x` appearing in the phase
`e^{i M τ}` of the space-time translation `T(x)`. -/
noncomputable def properTime (w : Fin 3 → ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) : ℝ :=
  gamma w * x0 - ∑ i, w i * xs i

/-- `τ` is additive in the space-time translation `x = (x₀, xs)`: it is a group
homomorphism `(ℝ⁴, +) → (ℝ, +)` (for a fixed spatial momentum `w`). -/
lemma properTime_add (w : Fin 3 → ℝ) (x0 y0 : ℝ) (xs ys : Fin 3 → ℝ) :
    properTime w (x0 + y0) (xs + ys) = properTime w x0 xs + properTime w y0 ys := by
  unfold properTime
  simp only [Pi.add_apply, mul_add, Finset.sum_add_distrib]
  ring

/-- `τ(γv, 0) = 0`. -/
lemma properTime_zero (w : Fin 3 → ℝ) : properTime w 0 (0 : Fin 3 → ℝ) = 0 := by
  unfold properTime; simp

/-- In the rest frame `γv = 0` the proper time equals the coordinate time,
`τ = x₀`. -/
lemma properTime_rest (x0 : ℝ) (xs : Fin 3 → ℝ) :
    properTime (fun _ => 0) x0 xs = x0 := by
  unfold properTime; simp [gamma_zero]

/-- The space-time translation phase `T(x) = e^{i M τ(γv, x)}` in the
momentum-diagonal basis, acting (by multiplication) on the eigenfunction of
spatial momentum `w = γv`. -/
noncomputable def transPhase (M : ℝ) (w : Fin 3 → ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) : ℂ :=
  Complex.exp (Complex.I * (M : ℂ) * (properTime w x0 xs : ℂ))

/-- `T(0) = 1`. -/
lemma transPhase_zero (M : ℝ) (w : Fin 3 → ℝ) :
    transPhase M w 0 (0 : Fin 3 → ℝ) = 1 := by
  unfold transPhase; rw [properTime_zero]; simp

/-- **Headline**: the space-time translation phases compose,
`T(x + y) = T(x) · T(y)`; together with `transPhase_zero` this exhibits
`x ↦ transPhase M w x` as a one-dimensional representation of the space-time
translation group `(ℝ⁴, +)`. -/
lemma transPhase_add (M : ℝ) (w : Fin 3 → ℝ) (x0 y0 : ℝ) (xs ys : Fin 3 → ℝ) :
    transPhase M w (x0 + y0) (xs + ys) = transPhase M w x0 xs * transPhase M w y0 ys := by
  unfold transPhase
  rw [properTime_add, ← Complex.exp_add]
  congr 1
  push_cast
  ring

/-- Each translation `T(x)` is **unitary** (`‖T(x)‖ = 1`), for a real invariant
mass `M`: the representation is by phases. -/
lemma transPhase_norm (M : ℝ) (w : Fin 3 → ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) :
    ‖transPhase M w x0 xs‖ = 1 := by
  unfold transPhase
  rw [Complex.norm_exp]
  have : (Complex.I * (M : ℂ) * (properTime w x0 xs : ℂ)).re = 0 := by
    simp [Complex.mul_re, Complex.mul_im]
  rw [this, Real.exp_zero]

/-- In the rest frame `γv = 0`, the space-time translation reduces to the
non-relativistic time-evolution phase `T(x) = e^{i M x₀}` (`M` as Hamiltonian,
`x₀` as time). -/
lemma transPhase_rest (M : ℝ) (x0 : ℝ) (xs : Fin 3 → ℝ) :
    transPhase M (fun _ => 0) x0 xs = Complex.exp (Complex.I * (M : ℂ) * (x0 : ℂ)) := by
  unfold transPhase; rw [properTime_rest]

end BookProof.ChapterLorentzTranslation
