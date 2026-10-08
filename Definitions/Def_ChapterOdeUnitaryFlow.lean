import Mathlib


/-!
# The unitary time-evolution of the blow-up ODE `ẋ = x²`

Source: `book.tex`, chapter *"Resolution of the singularity of the ODE x'=x^2 when the
initial x has uncertainties"*, §*State-of-the-art* (Equation 1) and §*Resolution of the
singularity using the uncertainties in x* (Equations 2–4).

The chapter's computation is the following.  The classical initial-value problem

```
ẋ = x²,   x(0) = x₀
```

has the solution `x(t) = x₀ / (1 - t x₀)` (Equation 1), which **blows up** at the finite
time `t = 1/x₀` when `x₀ > 0`: there is no global deterministic solution.  The book then
quantizes the vector field, `H = x² p - i x`, diagonalizes `H` by the kernel
`U(x,p) = e^{-i p / x} / (√(2π) x)` and evaluates the resulting time-evolution kernel,
obtaining (Equation 3)

```
(e^{-i H t} ψ)(x) = 1/(x t + 1) · ψ( x / (x t + 1) )
```

and, for a multiplication operator `ρ` (a probability density in the `x`-basis),
(Equation 4)

```
(e^{-i H t} ρ e^{+i H t} ψ)(x) = ρ( x / (x t + 1) ) · ψ(x) .
```

This file formalizes that computation *as an independent mathematical statement*: we
**define** the operator family of Equation 3 and prove that it is what the book claims it
is — a one-parameter group of **probability-preserving** operators on `L²(ℝ)` whose
generator is exactly `-i H`, and which conjugates a multiplication operator as in
Equation 4.  Nothing here presupposes the (merely formal) manipulations with the
δ-function kernel of the source text; the point of the formalization is that the *result*
of those manipulations is correct, and that it does resolve the singularity at the level
of probability measures: **for every real time `t`, including times beyond the classical
blow-up, total probability is exactly conserved** (`odeKoop_lintegral_normSq`).

The mechanism is visible in the formulas.  The flow map

```
mob t x = x / (1 + t x)
```

is a Möbius map which is *not* defined at the single point `x = -1/t`, and which maps
`ℝ \ {-1/t}` bijectively onto `ℝ \ {1/t}`.  A single point is a Lebesgue-null set, so as a
transformation of the *probability space* the flow is a bijection up to null sets: what
"escapes to `+∞`" re-enters at `-∞`.  The pointwise trajectory of a single initial
condition still blows up (`classicalSol_tendsto_atTop`), but the evolution of the
uncertainty — the wave-function — is global and norm-preserving.

## Main results

* `classicalSol_hasDerivAt`, `classicalSol_zero` — Equation 1 solves `ẋ = x²`.
* `classicalSol_tendsto_atTop` — and blows up at `t = 1/x₀` for `x₀ > 0`.
* `mob_mob`, `mob_zero`, `mob_neg_mob` — the Möbius flow is a group action off the pole.
* `odeKoop_add`, `odeKoop_zero` — Equation 3 defines a one-parameter group.
* `odeKoop_lintegral_normSq` — **probability conservation for every `t`** (the `L²`
  isometry; the headline).
* `odeKoop_conj_mul` — Equation 4: conjugation of a multiplication operator.
* `hasDerivAt_odeKoop_zero`, `odeKoop_generator` — the generator of the group is `-i H`
  with `H = x² p - i x`, `p = -i ∂ₓ`: Equation 3 solves the Schrödinger equation of the
  quantized vector field.
-/

namespace BookProof.OdeUnitaryFlow

open MeasureTheory Filter Set
open scoped Topology ENNReal

/-! ## The classical solution and its blow-up -/

/-- Equation 1 of the chapter: the solution of `ẋ = x²` with `x(0) = x₀`. -/
noncomputable def classicalSol (x₀ t : ℝ) : ℝ := x₀ / (1 - t * x₀)

@[simp] theorem classicalSol_zero (x₀ : ℝ) : classicalSol x₀ 0 = x₀ := by
  simp [classicalSol]

`, chapter *"Resolution of the singularity of the ODE x'=x^2 when the
initial x has uncertainties"*, §*State-of-the-art* (Equation 1) and §*Resolution of the
singularity using the uncertainties in x* (Equations 2–4).

The chapter's computation is the following.  The classical initial-value problem

```
ẋ = x²,   x(0) = x₀
```

has the solution `x(t) = x₀ / (1 - t x₀)` (Equation 1), which **blows up** at the finite
time `t = 1/x₀` when `x₀ > 0`: there is no global deterministic solution.  The book then
quantizes the vector field, `H = x² p - i x`, diagonalizes `H` by the kernel
`U(x,p) = e^{-i p / x} / (√(2π) x)` and evaluates the resulting time-evolution kernel,
obtaining (Equation 3)

```
(e^{-i H t} ψ)(x) = 1/(x t + 1) · ψ( x / (x t + 1) )
```

and, for a multiplication operator `ρ` (a probability density in the `x`-basis),
(Equation 4)

```
(e^{-i H t} ρ e^{+i H t} ψ)(x) = ρ( x / (x t + 1) ) · ψ(x) .
```

This file formalizes that computation *as an independent mathematical statement*: we
**define** the operator family of Equation 3 and prove that it is what the book claims it
is — a one-parameter group of **probability-preserving** operators on `L²(ℝ)` whose
generator is exactly `-i H`, and which conjugates a multiplication operator as in
Equation 4.  Nothing here presupposes the (merely formal) manipulations with the
δ-function kernel of the source text; the point of the formalization is that the *result*
of those manipulations is correct, and that it does resolve the singularity at the level
of probability measures: **for every real time `t`, including times beyond the classical
blow-up, total probability is exactly conserved** (`odeKoop_lintegral_normSq`).

The mechanism is visible in the formulas.  The flow map

```
mob t x = x / (1 + t x)
```

is a Möbius map which is *not* defined at the single point `x = -1/t`, and which maps
`ℝ \ {-1/t}` bijectively onto `ℝ \ {1/t}`.  A single point is a Lebesgue-null set, so as a
transformation of the *probability space* the flow is a bijection up to null sets: what
"escapes to `+∞`" re-enters at `-∞`.  The pointwise trajectory of a single initial
condition still blows up (`classicalSol_tendsto_atTop`), but the evolution of the
uncertainty — the wave-function — is global and norm-preserving.

## Main results

* `classicalSol_hasDerivAt`, `classicalSol_zero` — Equation 1 solves `ẋ = x²`.
* `classicalSol_tendsto_atTop` — and blows up at `t = 1/x₀` for `x₀ > 0`.
* `mob_mob`, `mob_zero`, `mob_neg_mob` — the Möbius flow is a group action off the pole.
* `odeKoop_add`, `odeKoop_zero` — Equation 3 defines a one-parameter group.
* `odeKoop_lintegral_normSq` — **probability conservation for every `t`** (the `L²`
  isometry; the headline).
* `odeKoop_conj_mul` — Equation 4: conjugation of a multiplication operator.
* `hasDerivAt_odeKoop_zero`, `odeKoop_generator` — the generator of the group is `-i H`
  with `H = x² p - i x`, `p = -i ∂ₓ`: Equation 3 solves the Schrödinger equation of the
  quantized vector field.
-/

namespace BookProof.OdeUnitaryFlow

open MeasureTheory Filter Set
open scoped Topology ENNReal

/-! ## The classical solution and its blow-up -/

/-- Equation 1 of the chapter: the solution of `ẋ = x²` with `x(0) = x₀`. -/
noncomputable def classicalSol (x₀ t : ℝ) : ℝ := x₀ / (1 - t * x₀)

@[simp] theorem classicalSol_zero (x₀ : ℝ) : classicalSol x₀ 0 = x₀ := by
  simp [classicalSol]

/-- The classical solution solves the ODE `ẋ = x²` at every time before the blow-up. -/
theorem classicalSol_hasDerivAt (x₀ t : ℝ) (ht : 1 - t * x₀ ≠ 0) :
    HasDerivAt (classicalSol x₀) ((classicalSol x₀ t) ^ 2) t := by
  have hnum : HasDerivAt (fun t : ℝ => 1 - t * x₀) (-x₀) t := by
    simpa using ((hasDerivAt_id t).mul_const x₀).const_sub 1
  have h := (hasDerivAt_const t x₀).div hnum ht
  have heq : (0 * (1 - t * x₀) - x₀ * -x₀) / (1 - t * x₀) ^ 2 = (classicalSol x₀ t) ^ 2 := by
    simp only [classicalSol, div_pow]
    ring
  simp only [classicalSol, Pi.div_def, heq] at h ⊢
  exact h

/-- At `t = 1/x₀` the denominator of the classical solution vanishes: that is the
blow-up time. -/
theorem classicalSol_singular_time (x₀ : ℝ) (hx₀ : x₀ ≠ 0) : 1 - (1 / x₀) * x₀ = 0 := by
  rw [one_div, inv_mul_cancel₀ hx₀, sub_self]



/-! ## The Möbius flow -/

/-- The Möbius flow map `x ↦ x/(1 + t x)` appearing in Equation 3.  It is the classical
flow of `ẋ = x²` run *backwards*: `mob (-t) x₀ = classicalSol x₀ t`. -/
noncomputable def mob (t x : ℝ) : ℝ := x / (1 + t * x)



@[simp] theorem mob_zero (x : ℝ) : mob 0 x = x := by simp [mob]

/-- The set of points at which the flow map at time `t` is defined. -/
def flowDom (t : ℝ) : Set ℝ := {x : ℝ | 1 + t * x ≠ 0}

















/-! ## Equation 3: the evolution operator -/

/-- **Equation 3**: the time-evolution operator `e^{-iHt}` of the quantized vector
field, `(e^{-iHt}ψ)(x) = ψ(x/(1+tx))/(1+tx)`. -/
noncomputable def odeKoop (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) : ℂ :=
  ((1 + t * x : ℝ) : ℂ)⁻¹ * ψ (mob t x)

@[simp] theorem odeKoop_zero (ψ : ℝ → ℂ) (x : ℝ) : odeKoop 0 ψ x = ψ x := by
  simp [odeKoop]





/-! ## Probability conservation -/











/-! ## Equation 4: conjugation of a multiplication operator -/



/-! ## The generator: the quantized vector field -/

/-- The value at `x` of the quantized Hamiltonian `H = x² p - i x` (with `p = -i ∂ₓ`)
applied to a function with value `v` and derivative `d` at `x`. -/
noncomputable def hamValue (x : ℝ) (d v : ℂ) : ℂ :=
  (x : ℂ) ^ 2 * (-Complex.I * d) - Complex.I * (x : ℂ) * v





/-! ## The change of variables `w = -1/x`: the evolution *is* a translation

The chapter observes that *"the Hamiltonian differs from the translation in space by a
change of variables `y → 1/x`"*.  We prove exactly that: the unitary change of variables
`W` induced by `x ↦ -1/x` intertwines the evolution of Equation 3 with the translation
group, `e^{-iHt} ∘ W = W ∘ T_t`.  This is the structural reason for the group law and for
the conservation of probability: on the `w`-chart the singular flow is just `w ↦ w - t`.
-/

/-- The change of variables `x ↦ -1/x` of the chapter (an involution of `ℝ \ {0}`). -/
noncomputable def invMap (x : ℝ) : ℝ := -1 / x


```

has the solution `x(t) = x₀ / (1 - t x₀)` (Equation 1), which **blows up** at the finite
time `t = 1/x₀` when `x₀ > 0`: there is no global deterministic solution.  The book then
quantizes the vector field, `H = x² p - i x`, diagonalizes `H` by the kernel
`U(x,p) = e^{-i p / x} / (√(2π) x)` and evaluates the resulting time-evolution kernel,
obtaining (Equation 3)

```
(e^{-i H t} ψ)(x) = 1/(x t + 1) · ψ( x / (x t + 1) )
```

and, for a multiplication operator `ρ` (a probability density in the `x`-basis),
(Equation 4)

```
(e^{-i H t} ρ e^{+i H t} ψ)(x) = ρ( x / (x t + 1) ) · ψ(x) .
```

This file formalizes that computation *as an independent mathematical statement*: we
**define** the operator family of Equation 3 and prove that it is what the book claims it
is — a one-parameter group of **probability-preserving** operators on `L²(ℝ)` whose
generator is exactly `-i H`, and which conjugates a multiplication operator as in
Equation 4.  Nothing here presupposes the (merely formal) manipulations with the
δ-function kernel of the source text; the point of the formalization is that the *result*
of those manipulations is correct, and that it does resolve the singularity at the level
of probability measures: **for every real time `t`, including times beyond the classical
blow-up, total probability is exactly conserved** (`odeKoop_lintegral_normSq`).

The mechanism is visible in the formulas.  The flow map

```
mob t x = x / (1 + t x)
```

is a Möbius map which is *not* defined at the single point `x = -1/t`, and which maps
`ℝ \ {-1/t}` bijectively onto `ℝ \ {1/t}`.  A single point is a Lebesgue-null set, so as a
transformation of the *probability space* the flow is a bijection up to null sets: what
"escapes to `+∞`" re-enters at `-∞`.  The pointwise trajectory of a single initial
condition still blows up (`classicalSol_tendsto_atTop`), but the evolution of the
uncertainty — the wave-function — is global and norm-preserving.

## Main results

* `classicalSol_hasDerivAt`, `classicalSol_zero` — Equation 1 solves `ẋ = x²`.
* `classicalSol_tendsto_atTop` — and blows up at `t = 1/x₀` for `x₀ > 0`.
* `mob_mob`, `mob_zero`, `mob_neg_mob` — the Möbius flow is a group action off the pole.
* `odeKoop_add`, `odeKoop_zero` — Equation 3 defines a one-parameter group.
* `odeKoop_lintegral_normSq` — **probability conservation for every `t`** (the `L²`
  isometry; the headline).
* `odeKoop_conj_mul` — Equation 4: conjugation of a multiplication operator.
* `hasDerivAt_odeKoop_zero`, `odeKoop_generator` — the generator of the group is `-i H`
  with `H = x² p - i x`, `p = -i ∂ₓ`: Equation 3 solves the Schrödinger equation of the
  quantized vector field.
-/

namespace BookProof.OdeUnitaryFlow

open MeasureTheory Filter Set
open scoped Topology ENNReal

/-! ## The classical solution and its blow-up -/

/-- Equation 1 of the chapter: the solution of `ẋ = x²` with `x(0) = x₀`. -/
noncomputable def classicalSol (x₀ t : ℝ) : ℝ := x₀ / (1 - t * x₀)

@[simp] theorem classicalSol_zero (x₀ : ℝ) : classicalSol x₀ 0 = x₀ := by
  simp [classicalSol]

/-- The classical solution solves the ODE `ẋ = x²` at every time before the blow-up. -/
theorem classicalSol_hasDerivAt (x₀ t : ℝ) (ht : 1 - t * x₀ ≠ 0) :
    HasDerivAt (classicalSol x₀) ((classicalSol x₀ t) ^ 2) t := by
  have hnum : HasDerivAt (fun t : ℝ => 1 - t * x₀) (-x₀) t := by
    simpa using ((hasDerivAt_id t).mul_const x₀).const_sub 1
  have h := (hasDerivAt_const t x₀).div hnum ht
  have heq : (0 * (1 - t * x₀) - x₀ * -x₀) / (1 - t * x₀) ^ 2 = (classicalSol x₀ t) ^ 2 := by
    simp only [classicalSol, div_pow]
    ring
  simp only [classicalSol, Pi.div_def, heq] at h ⊢
  exact h

/-- At `t = 1/x₀` the denominator of the classical solution vanishes: that is the
blow-up time. -/
theorem classicalSol_singular_time (x₀ : ℝ) (hx₀ : x₀ ≠ 0) : 1 - (1 / x₀) * x₀ = 0 := by
  rw [one_div, inv_mul_cancel₀ hx₀, sub_self]

/-- **Finite-time blow-up.**  For a positive initial condition the classical solution
diverges as the time approaches `1/x₀` from below. -/
theorem classicalSol_tendsto_atTop (x₀ : ℝ) (hx₀ : 0 < x₀) :
    Tendsto (classicalSol x₀) (𝓝[<] (1 / x₀)) atTop := by
  have hcont : Tendsto (fun t : ℝ => 1 - t * x₀) (𝓝 (1 / x₀)) (𝓝 0) := by
    have h : Tendsto (fun t : ℝ => 1 - t * x₀) (𝓝 (1 / x₀)) (𝓝 (1 - (1 / x₀) * x₀)) :=
      (tendsto_id.mul_const x₀).const_sub 1
    rwa [classicalSol_singular_time x₀ (ne_of_gt hx₀)] at h
  have hden : Tendsto (fun t : ℝ => 1 - t * x₀) (𝓝[<] (1 / x₀)) (𝓝[>] 0) := by
    refine tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _
      (hcont.mono_left nhdsWithin_le_nhds) ?_
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht' : t < 1 / x₀ := ht
    have h1 : t * x₀ < 1 := by
      have := (lt_div_iff₀ hx₀).mp ht'
      linarith
    simp only [mem_Ioi]
    linarith
  have hinv : Tendsto (fun t : ℝ => (1 - t * x₀)⁻¹) (𝓝[<] (1 / x₀)) atTop :=
    tendsto_inv_nhdsGT_zero.comp hden
  have h := hinv.const_mul_atTop hx₀
  simp only [classicalSol, div_eq_mul_inv] at ⊢
  exact h

/-! ## The Möbius flow -/

/-- The Möbius flow map `x ↦ x/(1 + t x)` appearing in Equation 3.  It is the classical
flow of `ẋ = x²` run *backwards*: `mob (-t) x₀ = classicalSol x₀ t`. -/
noncomputable def mob (t x : ℝ) : ℝ := x / (1 + t * x)

theorem mob_neg_eq_classicalSol (x₀ t : ℝ) : mob (-t) x₀ = classicalSol x₀ t := by
  have h : 1 + (-t) * x₀ = 1 - t * x₀ := by ring
  rw [mob, classicalSol, h]

@[simp] theorem mob_zero (x : ℝ) : mob 0 x = x := by simp [mob]

/-- The set of points at which the flow map at time `t` is defined. -/
def flowDom (t : ℝ) : Set ℝ := {x : ℝ | 1 + t * x ≠ 0}

theorem measurableSet_flowDom (t : ℝ) : MeasurableSet (flowDom t) := by
  have hc : Continuous fun x : ℝ => 1 + t * x := by fun_prop
  have hset : flowDom t = ((fun x : ℝ => 1 + t * x) ⁻¹' {0})ᶜ := by
    ext x; simp [flowDom]
  rw [hset]
  exact ((measurableSet_singleton (0 : ℝ)).preimage hc.measurable).compl

/-- The complement of the domain is a Lebesgue-null set (it is empty, or a single
point). -/
theorem volume_compl_flowDom (t : ℝ) : volume (flowDom t)ᶜ = 0 := by
  rcases eq_or_ne t 0 with rfl | ht
  · have h : (flowDom (0 : ℝ))ᶜ = (∅ : Set ℝ) := by
      ext x; simp [flowDom]
    simp [h]
  · have h : (flowDom t)ᶜ ⊆ {(-1 / t : ℝ)} := by
      intro x hx
      have hx' : 1 + t * x = 0 := by
        simpa [flowDom, not_not] using hx
      have : x = -1 / t := by field_simp; linarith
      simp [this]
    exact measure_mono_null h (by simp)

theorem one_sub_mul_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    1 - t * mob t x = (1 + t * x)⁻¹ := by
  have h : 1 + t * x ≠ 0 := hx
  simp only [mob]
  field_simp
  ring

theorem one_add_neg_mul_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    1 + (-t) * mob t x = (1 + t * x)⁻¹ := by
  have h := one_sub_mul_mob t x hx
  linear_combination h

theorem mob_mem_flowDom_neg (t x : ℝ) (hx : x ∈ flowDom t) : mob t x ∈ flowDom (-t) := by
  have h : 1 + t * x ≠ 0 := hx
  change 1 + (-t) * mob t x ≠ 0
  rw [one_add_neg_mul_mob t x hx]
  exact inv_ne_zero h

/-- Running the flow backwards undoes it. -/
theorem mob_neg_mob (t x : ℝ) (hx : x ∈ flowDom t) : mob (-t) (mob t x) = x := by
  have h : 1 + t * x ≠ 0 := hx
  have hkey : mob (-t) (mob t x) = mob t x / (1 + t * x)⁻¹ := by
    rw [mob, one_add_neg_mul_mob t x hx]
  rw [hkey, mob, div_eq_iff (inv_ne_zero h), div_eq_mul_inv]

/-- The Möbius denominators compose. -/
theorem one_add_mul_mob (s t x : ℝ) (hx : 1 + t * x ≠ 0) :
    1 + s * mob t x = (1 + (s + t) * x) / (1 + t * x) := by
  have hx' : 1 + x * t ≠ 0 := by rwa [mul_comm] at hx
  rw [mob, eq_div_iff hx]
  field_simp
  ring

/-- **The flow property** of the Möbius maps (off the poles). -/
theorem mob_mob (s t x : ℝ) (hx : 1 + t * x ≠ 0) (hst : 1 + (s + t) * x ≠ 0) :
    mob s (mob t x) = mob (s + t) x := by
  have hkey : mob s (mob t x) = mob t x / ((1 + (s + t) * x) / (1 + t * x)) := by
    rw [mob, one_add_mul_mob s t x hx]
  have hx' : 1 + x * t ≠ 0 := by rwa [mul_comm] at hx
  have hst' : 1 + x * (s + t) ≠ 0 := by rwa [mul_comm] at hst
  rw [hkey, mob, mob]
  field_simp

/-! ## Equation 3: the evolution operator -/

/-- **Equation 3**: the time-evolution operator `e^{-iHt}` of the quantized vector
field, `(e^{-iHt}ψ)(x) = ψ(x/(1+tx))/(1+tx)`. -/
noncomputable def odeKoop (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) : ℂ :=
  ((1 + t * x : ℝ) : ℂ)⁻¹ * ψ (mob t x)

@[simp] theorem odeKoop_zero (ψ : ℝ → ℂ) (x : ℝ) : odeKoop 0 ψ x = ψ x := by
  simp [odeKoop]

/-- **The group law** `e^{-iHs} e^{-iHt} = e^{-iH(s+t)}`, at every point where all three
flow maps are defined. -/
theorem odeKoop_add (s t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hs : 1 + s * x ≠ 0)
    (hst : 1 + (s + t) * x ≠ 0) :
    odeKoop s (odeKoop t ψ) x = odeKoop (s + t) ψ x := by
  have hts : 1 + (t + s) * x ≠ 0 := by rwa [add_comm t s]
  have hmob : mob t (mob s x) = mob (s + t) x := by
    rw [mob_mob t s x hs hts, add_comm t s]
  have hcast : ((1 + t * mob s x : ℝ) : ℂ)
      = ((1 + (s + t) * x : ℝ) : ℂ) / ((1 + s * x : ℝ) : ℂ) := by
    rw [one_add_mul_mob t s x hs, add_comm t s]
    push_cast
    ring
  have h1 : ((1 + s * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hs
  have h2 : ((1 + (s + t) * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hst
  simp only [odeKoop]
  rw [hmob, hcast]
  field_simp

/-- The inverse of the evolution at time `t` is the evolution at time `-t`. -/
theorem odeKoop_neg_odeKoop (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom (-t)) :
    odeKoop (-t) (odeKoop t ψ) x = ψ x := by
  have hx' : 1 + (-t) * x ≠ 0 := hx
  have h := odeKoop_add (-t) t ψ x hx' (by simp)
  rw [h]
  simp

/-! ## Probability conservation -/

theorem hasDerivAt_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    HasDerivAt (mob t) ((1 + t * x) ^ 2)⁻¹ x := by
  have h : 1 + t * x ≠ 0 := hx
  have hden : HasDerivAt (fun x : ℝ => 1 + t * x) t x := by
    simpa using ((hasDerivAt_id x).const_mul t).const_add 1
  have hq := (hasDerivAt_id x).div hden h
  have heq : (1 * (1 + t * x) - x * t) / (1 + t * x) ^ 2 = ((1 + t * x) ^ 2)⁻¹ := by
    field_simp
    ring
  simp only [mob, Pi.div_def, id_eq, heq] at hq
  exact hq

theorem injOn_mob (t : ℝ) : InjOn (mob t) (flowDom t) := by
  intro a ha b hb hab
  have ha' := mob_neg_mob t a ha
  have hb' := mob_neg_mob t b hb
  rw [← ha', ← hb', hab]

/-- The flow map at time `t` sends its domain **onto** the domain of the inverse flow. -/
theorem image_mob (t : ℝ) : mob t '' flowDom t = flowDom (-t) := by
  apply Set.Subset.antisymm
  · rintro y ⟨x, hx, rfl⟩
    exact mob_mem_flowDom_neg t x hx
  · intro y hy
    refine ⟨mob (-t) y, ?_, ?_⟩
    · have h := mob_mem_flowDom_neg (-t) y hy
      simpa using h
    · have h := mob_neg_mob (-t) y hy
      simpa using h

/-- **Probability conservation, in the form of a change of variables.**  For every
`g : ℝ → ℝ≥0∞`, the flow at time `t` transports the Lebesgue integral of `g` into the
weighted integral appearing in Equation 3. -/
theorem lintegral_comp_mob (t : ℝ) (g : ℝ → ℝ≥0∞) :
    ∫⁻ x, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x) = ∫⁻ y, g y := by
  have hderiv : ∀ x ∈ flowDom t, HasDerivWithinAt (mob t)
      ((fun x : ℝ => ((1 + t * x) ^ 2)⁻¹) x) (flowDom t) x := fun x hx =>
    (hasDerivAt_mob t x hx).hasDerivWithinAt
  have key := lintegral_image_eq_lintegral_abs_deriv_mul (measurableSet_flowDom t) hderiv
    (injOn_mob t) g
  rw [image_mob t] at key
  have habs : ∀ x : ℝ, |((1 + t * x) ^ 2)⁻¹| = ((1 + t * x) ^ 2)⁻¹ := fun x =>
    abs_of_nonneg (by positivity)
  simp only [habs] at key
  have hae : ∀ s : ℝ, flowDom s =ᵐ[volume] (Set.univ : Set ℝ) := fun s =>
    ae_eq_univ.mpr (volume_compl_flowDom s)
  have h1 : ∫⁻ y in flowDom (-t), g y = ∫⁻ y, g y := by
    rw [setLIntegral_congr (hae (-t)), setLIntegral_univ]
  have h2 : ∫⁻ x in flowDom t, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x)
      = ∫⁻ x, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x) := by
    rw [setLIntegral_congr (hae t), setLIntegral_univ]
  rw [← h2, ← h1, key]

/-- **The headline.**  For *every* real time `t` — in particular past the classical
blow-up time — the evolution of Equation 3 conserves total probability:
`∫ |e^{-iHt}ψ|² = ∫ |ψ|²`.  This is the sense in which admitting uncertainty in the
initial condition resolves the singularity of `ẋ = x²`. -/
theorem odeKoop_lintegral_normSq (t : ℝ) (ψ : ℝ → ℂ) :
    ∫⁻ x, ENNReal.ofReal (‖odeKoop t ψ x‖ ^ 2) = ∫⁻ y, ENNReal.ofReal (‖ψ y‖ ^ 2) := by
  have key := lintegral_comp_mob t (fun y => ENNReal.ofReal (‖ψ y‖ ^ 2))
  rw [← key]
  refine lintegral_congr fun x => ?_
  have hnorm : ‖odeKoop t ψ x‖ ^ 2 = ((1 + t * x) ^ 2)⁻¹ * ‖ψ (mob t x)‖ ^ 2 := by
    simp only [odeKoop, norm_mul, norm_inv, Complex.norm_real, mul_pow, inv_pow,
      Real.norm_eq_abs, sq_abs]
  rw [hnorm, ENNReal.ofReal_mul (by positivity)]

/-! ## Equation 4: conjugation of a multiplication operator -/

/-- **Equation 4**: conjugating the multiplication operator by a density `ρ` with the
evolution replaces `ρ` by `ρ ∘ mob t`; in particular a probability density in the
`x`-basis is transported by the classical flow. -/
theorem odeKoop_conj_mul (t : ℝ) (ρ ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom t) :
    odeKoop t (fun y => ρ y * odeKoop (-t) ψ y) x = ρ (mob t x) * ψ x := by
  have h : 1 + t * x ≠ 0 := hx
  have hc : ((1 + t * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast h
  have hback : mob (-t) (mob t x) = x := mob_neg_mob t x hx
  have hden : ((1 + (-t) * mob t x : ℝ) : ℂ) = (((1 + t * x)⁻¹ : ℝ) : ℂ) := by
    rw [one_add_neg_mul_mob t x hx]
  have hc' : (1 + (t : ℂ) * (x : ℂ)) ≠ 0 := by push_cast at hc; exact hc
  simp only [odeKoop, hback, hden]
  push_cast
  field_simp

/-! ## The generator: the quantized vector field -/

/-- The value at `x` of the quantized Hamiltonian `H = x² p - i x` (with `p = -i ∂ₓ`)
applied to a function with value `v` and derivative `d` at `x`. -/
noncomputable def hamValue (x : ℝ) (d v : ℂ) : ℂ :=
  (x : ℂ) ^ 2 * (-Complex.I * d) - Complex.I * (x : ℂ) * v

/-- The time-derivative at `t = 0` of the evolution of Equation 3. -/
theorem hasDerivAt_odeKoop_zero (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x)) 0 := by
  have hlin : HasDerivAt (fun t : ℝ => 1 + t * x) x 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).mul_const x).const_add 1
  have h0 : (1 + (0 : ℝ) * x) ≠ 0 := by norm_num
  have hu : HasDerivAt (fun t : ℝ => (1 + t * x)⁻¹) (-x) 0 := by
    have h := hlin.inv h0
    simp at h
    exact h
  have hden : HasDerivAt (fun t : ℝ => ((1 + t * x : ℝ) : ℂ)⁻¹) (-(x : ℂ)) 0 := by
    have h := Complex.ofRealCLM.hasDerivAt.scomp (0 : ℝ) hu
    simpa [Function.comp_def, Complex.ofReal_inv] using h
  have hmobt : HasDerivAt (fun t : ℝ => mob t x) (-(x ^ 2)) 0 := by
    have h := hu.const_mul x
    have hfun : (fun t : ℝ => x * (1 + t * x)⁻¹) = fun t : ℝ => mob t x := by
      funext t; simp [mob, div_eq_mul_inv]
    rw [hfun] at h
    simpa [pow_two] using h
  have hψ0 : HasDerivAt ψ d (mob 0 x) := by simpa using hψ
  have hcomp : HasDerivAt (fun t : ℝ => ψ (mob t x)) ((-(x ^ 2) : ℝ) • d) 0 := by
    have h := hψ0.scomp (0 : ℝ) hmobt
    simpa [Function.comp_def] using h
  have hmul := hden.mul hcomp
  have hfun : (fun t : ℝ => odeKoop t ψ x)
      = fun t : ℝ => ((1 + t * x : ℝ) : ℂ)⁻¹ * ψ (mob t x) := rfl
  rw [hfun]
  convert hmul using 1
  · rfl
  · rfl
  · rw [mob_zero]
    norm_num [Complex.real_smul, Complex.ofReal_pow]

/-- **The generator of the group is `-iH`.**  Equation 3 solves the Schrödinger equation
of the Weyl-quantized vector field `H = x² p - i x` at `t = 0`; combined with the group
law `odeKoop_add`, at every time. -/
theorem odeKoop_generator (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-Complex.I * hamValue x d (ψ x)) 0 := by
  have h : -Complex.I * hamValue x d (ψ x) = -((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x) := by
    simp only [hamValue]
    linear_combination ((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x) * Complex.I_sq
  rw [h]
  exact hasDerivAt_odeKoop_zero ψ x d hψ

/-! ## The change of variables `w = -1/x`: the evolution *is* a translation

The chapter observes that *"the Hamiltonian differs from the translation in space by a
change of variables `y → 1/x`"*.  We prove exactly that: the unitary change of variables
`W` induced by `x ↦ -1/x` intertwines the evolution of Equation 3 with the translation
group, `e^{-iHt} ∘ W = W ∘ T_t`.  This is the structural reason for the group law and for
the conservation of probability: on the `w`-chart the singular flow is just `w ↦ w - t`.
-/

/-- The change of variables `x ↦ -1/x` of the chapter (an involution of `ℝ \ {0}`). -/
noncomputable def invMap (x : ℝ) : ℝ := -1 / x

theorem invMap_invMap {x : ℝ} (hx : x ≠ 0) : invMap (invMap x) = x := by
  simp only [invMap]
  field_simp



/-- The unitary implementing the change of variables on wave-functions:
`(Wψ)(x) = ψ(-1/x)/x`. -/
noncomputable def chartW (ψ : ℝ → ℂ) (x : ℝ) : ℂ := ((x : ℝ) : ℂ)⁻¹ * ψ (invMap x)

/-- Translation of a wave-function by the time `t`. -/
def transl (t : ℝ) (ψ : ℝ → ℂ) (w : ℝ) : ℂ := ψ (w - t)



/-- **The evolution is the translation group in the chart `w = -1/x`.**  This is the
chapter's sentence *"the Hamiltonian differs from the translation in space by a change of
variables"*, as an exact identity. -/
theorem odeKoop_chartW (t : ℝ) (ψ : ℝ → ℂ) {x : ℝ} (hx : x ≠ 0) (h : 1 + t * x ≠ 0) :
    odeKoop t (chartW ψ) x = chartW (transl t ψ) x := by
  have hmob : mob t x ≠ 0 := by
    simp only [mob]
    exact div_ne_zero hx h
  have hmobval : ((mob t x : ℝ) : ℂ)⁻¹ = ((1 + t * x : ℝ) : ℂ) * ((x : ℝ) : ℂ)⁻¹ := by
    have : mob t x = x / (1 + t * x) := rfl
    rw [this]
    push_cast
    have hxc : ((x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hx
    have hc : ((1 + t * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast h
    push_cast at hc ⊢
    field_simp
  have hxc : ((x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hx
  have hc : ((1 + t * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast h
  simp only [odeKoop, chartW, transl, invMap_mob hx, hmobval]
  field_simp

/-! ### The chart is norm-preserving -/







on 1), which **blows up** at the finite
time `t = 1/x₀` when `x₀ > 0`: there is no global deterministic solution.  The book then
quantizes the vector field, `H = x² p - i x`, diagonalizes `H` by the kernel
`U(x,p) = e^{-i p / x} / (√(2π) x)` and evaluates the resulting time-evolution kernel,
obtaining (Equation 3)

```
(e^{-i H t} ψ)(x) = 1/(x t + 1) · ψ( x / (x t + 1) )
```

and, for a multiplication operator `ρ` (a probability density in the `x`-basis),
(Equation 4)

```
(e^{-i H t} ρ e^{+i H t} ψ)(x) = ρ( x / (x t + 1) ) · ψ(x) .
```

This file formalizes that computation *as an independent mathematical statement*: we
**define** the operator family of Equation 3 and prove that it is what the book claims it
is — a one-parameter group of **probability-preserving** operators on `L²(ℝ)` whose
generator is exactly `-i H`, and which conjugates a multiplication operator as in
Equation 4.  Nothing here presupposes the (merely formal) manipulations with the
δ-function kernel of the source text; the point of the formalization is that the *result*
of those manipulations is correct, and that it does resolve the singularity at the level
of probability measures: **for every real time `t`, including times beyond the classical
blow-up, total probability is exactly conserved** (`odeKoop_lintegral_normSq`).

The mechanism is visible in the formulas.  The flow map

```
mob t x = x / (1 + t x)
```

is a Möbius map which is *not* defined at the single point `x = -1/t`, and which maps
`ℝ \ {-1/t}` bijectively onto `ℝ \ {1/t}`.  A single point is a Lebesgue-null set, so as a
transformation of the *probability space* the flow is a bijection up to null sets: what
"escapes to `+∞`" re-enters at `-∞`.  The pointwise trajectory of a single initial
condition still blows up (`classicalSol_tendsto_atTop`), but the evolution of the
uncertainty — the wave-function — is global and norm-preserving.

## Main results

* `classicalSol_hasDerivAt`, `classicalSol_zero` — Equation 1 solves `ẋ = x²`.
* `classicalSol_tendsto_atTop` — and blows up at `t = 1/x₀` for `x₀ > 0`.
* `mob_mob`, `mob_zero`, `mob_neg_mob` — the Möbius flow is a group action off the pole.
* `odeKoop_add`, `odeKoop_zero` — Equation 3 defines a one-parameter group.
* `odeKoop_lintegral_normSq` — **probability conservation for every `t`** (the `L²`
  isometry; the headline).
* `odeKoop_conj_mul` — Equation 4: conjugation of a multiplication operator.
* `hasDerivAt_odeKoop_zero`, `odeKoop_generator` — the generator of the group is `-i H`
  with `H = x² p - i x`, `p = -i ∂ₓ`: Equation 3 solves the Schrödinger equation of the
  quantized vector field.
-/

namespace BookProof.OdeUnitaryFlow

open MeasureTheory Filter Set
open scoped Topology ENNReal

/-! ## The classical solution and its blow-up -/

/-- Equation 1 of the chapter: the solution of `ẋ = x²` with `x(0) = x₀`. -/
noncomputable def classicalSol (x₀ t : ℝ) : ℝ := x₀ / (1 - t * x₀)

@[simp] theorem classicalSol_zero (x₀ : ℝ) : classicalSol x₀ 0 = x₀ := by
  simp [classicalSol]

/-- The classical solution solves the ODE `ẋ = x²` at every time before the blow-up. -/
theorem classicalSol_hasDerivAt (x₀ t : ℝ) (ht : 1 - t * x₀ ≠ 0) :
    HasDerivAt (classicalSol x₀) ((classicalSol x₀ t) ^ 2) t := by
  have hnum : HasDerivAt (fun t : ℝ => 1 - t * x₀) (-x₀) t := by
    simpa using ((hasDerivAt_id t).mul_const x₀).const_sub 1
  have h := (hasDerivAt_const t x₀).div hnum ht
  have heq : (0 * (1 - t * x₀) - x₀ * -x₀) / (1 - t * x₀) ^ 2 = (classicalSol x₀ t) ^ 2 := by
    simp only [classicalSol, div_pow]
    ring
  simp only [classicalSol, Pi.div_def, heq] at h ⊢
  exact h

/-- At `t = 1/x₀` the denominator of the classical solution vanishes: that is the
blow-up time. -/
theorem classicalSol_singular_time (x₀ : ℝ) (hx₀ : x₀ ≠ 0) : 1 - (1 / x₀) * x₀ = 0 := by
  rw [one_div, inv_mul_cancel₀ hx₀, sub_self]

/-- **Finite-time blow-up.**  For a positive initial condition the classical solution
diverges as the time approaches `1/x₀` from below. -/
theorem classicalSol_tendsto_atTop (x₀ : ℝ) (hx₀ : 0 < x₀) :
    Tendsto (classicalSol x₀) (𝓝[<] (1 / x₀)) atTop := by
  have hcont : Tendsto (fun t : ℝ => 1 - t * x₀) (𝓝 (1 / x₀)) (𝓝 0) := by
    have h : Tendsto (fun t : ℝ => 1 - t * x₀) (𝓝 (1 / x₀)) (𝓝 (1 - (1 / x₀) * x₀)) :=
      (tendsto_id.mul_const x₀).const_sub 1
    rwa [classicalSol_singular_time x₀ (ne_of_gt hx₀)] at h
  have hden : Tendsto (fun t : ℝ => 1 - t * x₀) (𝓝[<] (1 / x₀)) (𝓝[>] 0) := by
    refine tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _
      (hcont.mono_left nhdsWithin_le_nhds) ?_
    filter_upwards [self_mem_nhdsWithin] with t ht
    have ht' : t < 1 / x₀ := ht
    have h1 : t * x₀ < 1 := by
      have := (lt_div_iff₀ hx₀).mp ht'
      linarith
    simp only [mem_Ioi]
    linarith
  have hinv : Tendsto (fun t : ℝ => (1 - t * x₀)⁻¹) (𝓝[<] (1 / x₀)) atTop :=
    tendsto_inv_nhdsGT_zero.comp hden
  have h := hinv.const_mul_atTop hx₀
  simp only [classicalSol, div_eq_mul_inv] at ⊢
  exact h

/-! ## The Möbius flow -/

/-- The Möbius flow map `x ↦ x/(1 + t x)` appearing in Equation 3.  It is the classical
flow of `ẋ = x²` run *backwards*: `mob (-t) x₀ = classicalSol x₀ t`. -/
noncomputable def mob (t x : ℝ) : ℝ := x / (1 + t * x)

theorem mob_neg_eq_classicalSol (x₀ t : ℝ) : mob (-t) x₀ = classicalSol x₀ t := by
  have h : 1 + (-t) * x₀ = 1 - t * x₀ := by ring
  rw [mob, classicalSol, h]

@[simp] theorem mob_zero (x : ℝ) : mob 0 x = x := by simp [mob]

/-- The set of points at which the flow map at time `t` is defined. -/
def flowDom (t : ℝ) : Set ℝ := {x : ℝ | 1 + t * x ≠ 0}

theorem measurableSet_flowDom (t : ℝ) : MeasurableSet (flowDom t) := by
  have hc : Continuous fun x : ℝ => 1 + t * x := by fun_prop
  have hset : flowDom t = ((fun x : ℝ => 1 + t * x) ⁻¹' {0})ᶜ := by
    ext x; simp [flowDom]
  rw [hset]
  exact ((measurableSet_singleton (0 : ℝ)).preimage hc.measurable).compl

/-- The complement of the domain is a Lebesgue-null set (it is empty, or a single
point). -/
theorem volume_compl_flowDom (t : ℝ) : volume (flowDom t)ᶜ = 0 := by
  rcases eq_or_ne t 0 with rfl | ht
  · have h : (flowDom (0 : ℝ))ᶜ = (∅ : Set ℝ) := by
      ext x; simp [flowDom]
    simp [h]
  · have h : (flowDom t)ᶜ ⊆ {(-1 / t : ℝ)} := by
      intro x hx
      have hx' : 1 + t * x = 0 := by
        simpa [flowDom, not_not] using hx
      have : x = -1 / t := by field_simp; linarith
      simp [this]
    exact measure_mono_null h (by simp)

theorem one_sub_mul_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    1 - t * mob t x = (1 + t * x)⁻¹ := by
  have h : 1 + t * x ≠ 0 := hx
  simp only [mob]
  field_simp
  ring

theorem one_add_neg_mul_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    1 + (-t) * mob t x = (1 + t * x)⁻¹ := by
  have h := one_sub_mul_mob t x hx
  linear_combination h

theorem mob_mem_flowDom_neg (t x : ℝ) (hx : x ∈ flowDom t) : mob t x ∈ flowDom (-t) := by
  have h : 1 + t * x ≠ 0 := hx
  change 1 + (-t) * mob t x ≠ 0
  rw [one_add_neg_mul_mob t x hx]
  exact inv_ne_zero h

/-- Running the flow backwards undoes it. -/
theorem mob_neg_mob (t x : ℝ) (hx : x ∈ flowDom t) : mob (-t) (mob t x) = x := by
  have h : 1 + t * x ≠ 0 := hx
  have hkey : mob (-t) (mob t x) = mob t x / (1 + t * x)⁻¹ := by
    rw [mob, one_add_neg_mul_mob t x hx]
  rw [hkey, mob, div_eq_iff (inv_ne_zero h), div_eq_mul_inv]

/-- The Möbius denominators compose. -/
theorem one_add_mul_mob (s t x : ℝ) (hx : 1 + t * x ≠ 0) :
    1 + s * mob t x = (1 + (s + t) * x) / (1 + t * x) := by
  have hx' : 1 + x * t ≠ 0 := by rwa [mul_comm] at hx
  rw [mob, eq_div_iff hx]
  field_simp
  ring

/-- **The flow property** of the Möbius maps (off the poles). -/
theorem mob_mob (s t x : ℝ) (hx : 1 + t * x ≠ 0) (hst : 1 + (s + t) * x ≠ 0) :
    mob s (mob t x) = mob (s + t) x := by
  have hkey : mob s (mob t x) = mob t x / ((1 + (s + t) * x) / (1 + t * x)) := by
    rw [mob, one_add_mul_mob s t x hx]
  have hx' : 1 + x * t ≠ 0 := by rwa [mul_comm] at hx
  have hst' : 1 + x * (s + t) ≠ 0 := by rwa [mul_comm] at hst
  rw [hkey, mob, mob]
  field_simp

/-! ## Equation 3: the evolution operator -/

/-- **Equation 3**: the time-evolution operator `e^{-iHt}` of the quantized vector
field, `(e^{-iHt}ψ)(x) = ψ(x/(1+tx))/(1+tx)`. -/
noncomputable def odeKoop (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) : ℂ :=
  ((1 + t * x : ℝ) : ℂ)⁻¹ * ψ (mob t x)

@[simp] theorem odeKoop_zero (ψ : ℝ → ℂ) (x : ℝ) : odeKoop 0 ψ x = ψ x := by
  simp [odeKoop]

/-- **The group law** `e^{-iHs} e^{-iHt} = e^{-iH(s+t)}`, at every point where all three
flow maps are defined. -/
theorem odeKoop_add (s t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hs : 1 + s * x ≠ 0)
    (hst : 1 + (s + t) * x ≠ 0) :
    odeKoop s (odeKoop t ψ) x = odeKoop (s + t) ψ x := by
  have hts : 1 + (t + s) * x ≠ 0 := by rwa [add_comm t s]
  have hmob : mob t (mob s x) = mob (s + t) x := by
    rw [mob_mob t s x hs hts, add_comm t s]
  have hcast : ((1 + t * mob s x : ℝ) : ℂ)
      = ((1 + (s + t) * x : ℝ) : ℂ) / ((1 + s * x : ℝ) : ℂ) := by
    rw [one_add_mul_mob t s x hs, add_comm t s]
    push_cast
    ring
  have h1 : ((1 + s * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hs
  have h2 : ((1 + (s + t) * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hst
  simp only [odeKoop]
  rw [hmob, hcast]
  field_simp

/-- The inverse of the evolution at time `t` is the evolution at time `-t`. -/
theorem odeKoop_neg_odeKoop (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom (-t)) :
    odeKoop (-t) (odeKoop t ψ) x = ψ x := by
  have hx' : 1 + (-t) * x ≠ 0 := hx
  have h := odeKoop_add (-t) t ψ x hx' (by simp)
  rw [h]
  simp

/-! ## Probability conservation -/

theorem hasDerivAt_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    HasDerivAt (mob t) ((1 + t * x) ^ 2)⁻¹ x := by
  have h : 1 + t * x ≠ 0 := hx
  have hden : HasDerivAt (fun x : ℝ => 1 + t * x) t x := by
    simpa using ((hasDerivAt_id x).const_mul t).const_add 1
  have hq := (hasDerivAt_id x).div hden h
  have heq : (1 * (1 + t * x) - x * t) / (1 + t * x) ^ 2 = ((1 + t * x) ^ 2)⁻¹ := by
    field_simp
    ring
  simp only [mob, Pi.div_def, id_eq, heq] at hq
  exact hq

theorem injOn_mob (t : ℝ) : InjOn (mob t) (flowDom t) := by
  intro a ha b hb hab
  have ha' := mob_neg_mob t a ha
  have hb' := mob_neg_mob t b hb
  rw [← ha', ← hb', hab]

/-- The flow map at time `t` sends its domain **onto** the domain of the inverse flow. -/
theorem image_mob (t : ℝ) : mob t '' flowDom t = flowDom (-t) := by
  apply Set.Subset.antisymm
  · rintro y ⟨x, hx, rfl⟩
    exact mob_mem_flowDom_neg t x hx
  · intro y hy
    refine ⟨mob (-t) y, ?_, ?_⟩
    · have h := mob_mem_flowDom_neg (-t) y hy
      simpa using h
    · have h := mob_neg_mob (-t) y hy
      simpa using h

/-- **Probability conservation, in the form of a change of variables.**  For every
`g : ℝ → ℝ≥0∞`, the flow at time `t` transports the Lebesgue integral of `g` into the
weighted integral appearing in Equation 3. -/
theorem lintegral_comp_mob (t : ℝ) (g : ℝ → ℝ≥0∞) :
    ∫⁻ x, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x) = ∫⁻ y, g y := by
  have hderiv : ∀ x ∈ flowDom t, HasDerivWithinAt (mob t)
      ((fun x : ℝ => ((1 + t * x) ^ 2)⁻¹) x) (flowDom t) x := fun x hx =>
    (hasDerivAt_mob t x hx).hasDerivWithinAt
  have key := lintegral_image_eq_lintegral_abs_deriv_mul (measurableSet_flowDom t) hderiv
    (injOn_mob t) g
  rw [image_mob t] at key
  have habs : ∀ x : ℝ, |((1 + t * x) ^ 2)⁻¹| = ((1 + t * x) ^ 2)⁻¹ := fun x =>
    abs_of_nonneg (by positivity)
  simp only [habs] at key
  have hae : ∀ s : ℝ, flowDom s =ᵐ[volume] (Set.univ : Set ℝ) := fun s =>
    ae_eq_univ.mpr (volume_compl_flowDom s)
  have h1 : ∫⁻ y in flowDom (-t), g y = ∫⁻ y, g y := by
    rw [setLIntegral_congr (hae (-t)), setLIntegral_univ]
  have h2 : ∫⁻ x in flowDom t, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x)
      = ∫⁻ x, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x) := by
    rw [setLIntegral_congr (hae t), setLIntegral_univ]
  rw [← h2, ← h1, key]

/-- **The headline.**  For *every* real time `t` — in particular past the classical
blow-up time — the evolution of Equation 3 conserves total probability:
`∫ |e^{-iHt}ψ|² = ∫ |ψ|²`.  This is the sense in which admitting uncertainty in the
initial condition resolves the singularity of `ẋ = x²`. -/
theorem odeKoop_lintegral_normSq (t : ℝ) (ψ : ℝ → ℂ) :
    ∫⁻ x, ENNReal.ofReal (‖odeKoop t ψ x‖ ^ 2) = ∫⁻ y, ENNReal.ofReal (‖ψ y‖ ^ 2) := by
  have key := lintegral_comp_mob t (fun y => ENNReal.ofReal (‖ψ y‖ ^ 2))
  rw [← key]
  refine lintegral_congr fun x => ?_
  have hnorm : ‖odeKoop t ψ x‖ ^ 2 = ((1 + t * x) ^ 2)⁻¹ * ‖ψ (mob t x)‖ ^ 2 := by
    simp only [odeKoop, norm_mul, norm_inv, Complex.norm_real, mul_pow, inv_pow,
      Real.norm_eq_abs, sq_abs]
  rw [hnorm, ENNReal.ofReal_mul (by positivity)]

/-! ## Equation 4: conjugation of a multiplication operator -/

/-- **Equation 4**: conjugating the multiplication operator by a density `ρ` with the
evolution replaces `ρ` by `ρ ∘ mob t`; in particular a probability density in the
`x`-basis is transported by the classical flow. -/
theorem odeKoop_conj_mul (t : ℝ) (ρ ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom t) :
    odeKoop t (fun y => ρ y * odeKoop (-t) ψ y) x = ρ (mob t x) * ψ x := by
  have h : 1 + t * x ≠ 0 := hx
  have hc : ((1 + t * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast h
  have hback : mob (-t) (mob t x) = x := mob_neg_mob t x hx
  have hden : ((1 + (-t) * mob t x : ℝ) : ℂ) = (((1 + t * x)⁻¹ : ℝ) : ℂ) := by
    rw [one_add_neg_mul_mob t x hx]
  have hc' : (1 + (t : ℂ) * (x : ℂ)) ≠ 0 := by push_cast at hc; exact hc
  simp only [odeKoop, hback, hden]
  push_cast
  field_simp

/-! ## The generator: the quantized vector field -/

/-- The value at `x` of the quantized Hamiltonian `H = x² p - i x` (with `p = -i ∂ₓ`)
applied to a function with value `v` and derivative `d` at `x`. -/
noncomputable def hamValue (x : ℝ) (d v : ℂ) : ℂ :=
  (x : ℂ) ^ 2 * (-Complex.I * d) - Complex.I * (x : ℂ) * v

/-- The time-derivative at `t = 0` of the evolution of Equation 3. -/
theorem hasDerivAt_odeKoop_zero (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x)) 0 := by
  have hlin : HasDerivAt (fun t : ℝ => 1 + t * x) x 0 := by
    simpa using ((hasDerivAt_id (0 : ℝ)).mul_const x).const_add 1
  have h0 : (1 + (0 : ℝ) * x) ≠ 0 := by norm_num
  have hu : HasDerivAt (fun t : ℝ => (1 + t * x)⁻¹) (-x) 0 := by
    have h := hlin.inv h0
    simp at h
    exact h
  have hden : HasDerivAt (fun t : ℝ => ((1 + t * x : ℝ) : ℂ)⁻¹) (-(x : ℂ)) 0 := by
    have h := Complex.ofRealCLM.hasDerivAt.scomp (0 : ℝ) hu
    simpa [Function.comp_def, Complex.ofReal_inv] using h
  have hmobt : HasDerivAt (fun t : ℝ => mob t x) (-(x ^ 2)) 0 := by
    have h := hu.const_mul x
    have hfun : (fun t : ℝ => x * (1 + t * x)⁻¹) = fun t : ℝ => mob t x := by
      funext t; simp [mob, div_eq_mul_inv]
    rw [hfun] at h
    simpa [pow_two] using h
  have hψ0 : HasDerivAt ψ d (mob 0 x) := by simpa using hψ
  have hcomp : HasDerivAt (fun t : ℝ => ψ (mob t x)) ((-(x ^ 2) : ℝ) • d) 0 := by
    have h := hψ0.scomp (0 : ℝ) hmobt
    simpa [Function.comp_def] using h
  have hmul := hden.mul hcomp
  have hfun : (fun t : ℝ => odeKoop t ψ x)
      = fun t : ℝ => ((1 + t * x : ℝ) : ℂ)⁻¹ * ψ (mob t x) := rfl
  rw [hfun]
  convert hmul using 1
  · rfl
  · rfl
  · rw [mob_zero]
    norm_num [Complex.real_smul, Complex.ofReal_pow]

/-- **The generator of the group is `-iH`.**  Equation 3 solves the Schrödinger equation
of the Weyl-quantized vector field `H = x² p - i x` at `t = 0`; combined with the group
law `odeKoop_add`, at every time. -/
theorem odeKoop_generator (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-Complex.I * hamValue x d (ψ x)) 0 := by
  have h : -Complex.I * hamValue x d (ψ x) = -((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x) := by
    simp only [hamValue]
    linear_combination ((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x) * Complex.I_sq
  rw [h]
  exact hasDerivAt_odeKoop_zero ψ x d hψ

/-! ## The change of variables `w = -1/x`: the evolution *is* a translation

The chapter observes that *"the Hamiltonian differs from the translation in space by a
change of variables `y → 1/x`"*.  We prove exactly that: the unitary change of variables
`W` induced by `x ↦ -1/x` intertwines the evolution of Equation 3 with the translation
group, `e^{-iHt} ∘ W = W ∘ T_t`.  This is the structural reason for the group law and for
the conservation of probability: on the `w`-chart the singular flow is just `w ↦ w - t`.
-/

/-- The change of variables `x ↦ -1/x` of the chapter (an involution of `ℝ \ {0}`). -/
noncomputable def invMap (x : ℝ) : ℝ := -1 / x

theorem invMap_invMap {x : ℝ} (hx : x ≠ 0) : invMap (invMap x) = x := by
  simp only [invMap]
  field_simp

theorem invMap_ne_zero {x : ℝ} (hx : x ≠ 0) : invMap x ≠ 0 := by
  simp only [invMap]
  positivity

/-- The unitary implementing the change of variables on wave-functions:
`(Wψ)(x) = ψ(-1/x)/x`. -/
noncomputable def chartW (ψ : ℝ → ℂ) (x : ℝ) : ℂ := ((x : ℝ) : ℂ)⁻¹ * ψ (invMap x)

/-- Translation of a wave-function by the time `t`. -/
def transl (t : ℝ) (ψ : ℝ → ℂ) (w : ℝ) : ℂ := ψ (w - t)

theorem invMap_mob {t x : ℝ} (hx : x ≠ 0) :
    invMap (mob t x) = invMap x - t := by
  simp only [invMap, mob]
  field_simp
  ring

/-- **The evolution is the translation group in the chart `w = -1/x`.**  This is the
chapter's sentence *"the Hamiltonian differs from the translation in space by a change of
variables"*, as an exact identity. -/
theorem odeKoop_chartW (t : ℝ) (ψ : ℝ → ℂ) {x : ℝ} (hx : x ≠ 0) (h : 1 + t * x ≠ 0) :
    odeKoop t (chartW ψ) x = chartW (transl t ψ) x := by
  have hmob : mob t x ≠ 0 := by
    simp only [mob]
    exact div_ne_zero hx h
  have hmobval : ((mob t x : ℝ) : ℂ)⁻¹ = ((1 + t * x : ℝ) : ℂ) * ((x : ℝ) : ℂ)⁻¹ := by
    have : mob t x = x / (1 + t * x) := rfl
    rw [this]
    push_cast
    have hxc : ((x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hx
    have hc : ((1 + t * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast h
    push_cast at hc ⊢
    field_simp
  have hxc : ((x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hx
  have hc : ((1 + t * x : ℝ) : ℂ) ≠ 0 := by exact_mod_cast h
  simp only [odeKoop, chartW, transl, invMap_mob hx, hmobval]
  field_simp

/-! ### The chart is norm-preserving -/

theorem hasDerivAt_invMap {x : ℝ} (hx : x ≠ 0) : HasDerivAt invMap ((x ^ 2)⁻¹) x := by
  have h := (hasDerivAt_const x (-1 : ℝ)).div (hasDerivAt_id x) hx
  have heq : (0 * x - (-1 : ℝ) * 1) / x ^ 2 = (x ^ 2)⁻¹ := by
    field_simp
    ring
  simp only [invMap, Pi.div_def, id_eq, heq] at h
  exact h

theorem injOn_invMap : Set.InjOn invMap {x : ℝ | x ≠ 0} := by
  intro a ha b hb hab
  have ha' := invMap_invMap (x := a) ha
  have hb' := invMap_invMap (x := b) hb
  rw [← ha', ← hb', hab]

theorem image_invMap : invMap '' {x : ℝ | x ≠ 0} = {x : ℝ | x ≠ 0} := by
  apply Set.Subset.antisymm
  · rintro y ⟨x, hx, rfl⟩
    exact invMap_ne_zero hx
  · intro y hy
    exact ⟨invMap y, invMap_ne_zero hy, invMap_invMap hy⟩

/-- The change of variables `x ↦ -1/x` transports the Lebesgue integral with the Jacobian
`1/x²`. -/
theorem lintegral_comp_invMap (g : ℝ → ℝ≥0∞) :
    ∫⁻ x, ENNReal.ofReal ((x ^ 2)⁻¹) * g (invMap x) = ∫⁻ y, g y := by
  have hmeas : MeasurableSet {x : ℝ | x ≠ 0} := (measurableSet_singleton (0 : ℝ)).compl
  have hderiv : ∀ x ∈ {x : ℝ | x ≠ 0}, HasDerivWithinAt invMap
      ((fun x : ℝ => (x ^ 2)⁻¹) x) {x : ℝ | x ≠ 0} x := fun x hx =>
    (hasDerivAt_invMap hx).hasDerivWithinAt
  have key := lintegral_image_eq_lintegral_abs_deriv_mul hmeas hderiv injOn_invMap g
  rw [image_invMap] at key
  have habs : ∀ x : ℝ, |(x ^ 2)⁻¹| = (x ^ 2)⁻¹ := fun x => abs_of_nonneg (by positivity)
  simp only [habs] at key
  have hae : {x : ℝ | x ≠ 0} =ᵐ[volume] (Set.univ : Set ℝ) := by
    refine ae_eq_univ.mpr ?_
    have : {x : ℝ | x ≠ 0}ᶜ = ({0} : Set ℝ) := by
      ext x; simp
    rw [this]
    simp
  have h1 : ∫⁻ y in {x : ℝ | x ≠ 0}, g y = ∫⁻ y, g y := by
    rw [setLIntegral_congr hae, setLIntegral_univ]
  have h2 : ∫⁻ x in {x : ℝ | x ≠ 0}, ENNReal.ofReal ((x ^ 2)⁻¹) * g (invMap x)
      = ∫⁻ x, ENNReal.ofReal ((x ^ 2)⁻¹) * g (invMap x) := by
    rw [setLIntegral_congr hae, setLIntegral_univ]
  rw [← h2, ← h1, key]

/-- The chart `W` preserves the total probability, so it is a unitary of `L²(ℝ)`. -/
theorem chartW_lintegral_normSq (ψ : ℝ → ℂ) :
    ∫⁻ x, ENNReal.ofReal (‖chartW ψ x‖ ^ 2) = ∫⁻ y, ENNReal.ofReal (‖ψ y‖ ^ 2) := by
  have key := lintegral_comp_invMap (fun y => ENNReal.ofReal (‖ψ y‖ ^ 2))
  rw [← key]
  refine lintegral_congr fun x => ?_
  have hnorm : ‖chartW ψ x‖ ^ 2 = (x ^ 2)⁻¹ * ‖ψ (invMap x)‖ ^ 2 := by
    simp only [chartW, norm_mul, norm_inv, Complex.norm_real, mul_pow, inv_pow,
      Real.norm_eq_abs, sq_abs]
  rw [hnorm, ENNReal.ofReal_mul (by positivity)]

end BookProof.OdeUnitaryFlow
