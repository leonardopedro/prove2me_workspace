import Mathlib
import BookProof.ChapterBoseEinstein

/-!
# Chapter "The Coherent State of Attention", §"Temperature and the Thermal Bath" —
the finite algebraic core of the temperature identity (plan Part F.4 / A.4)

`ChapterCoherentTemperature` introduces the thermal occupation law through its
*mean* occupation `n̄` and defines the chapter's temperature as `τ = n̄ + 1/2`;
`ChapterBoseEinstein` re-parametrizes the same law by the physical inverse
temperature `x = ħω/kT` and derives the closed form `τ(x) = ½·coth(x/2)`.

This module supplies the **finite algebraic core** that Part A.4 of the plan
flagged as a gap: the geometric occupation law written directly in terms of its
*ratio* `r` (rather than its mean), its first two moments, the zero-point floor
that the extra `½` measures, and the headline that the Bose–Einstein closed form
`½·coth(x/2)` **is** the mean occupation plus one half — i.e. `τ = n̄ + ½` read
off the physical parametrization rather than posited.

## Deliverables

* `geometricOccupancy r n = (1 - r)·rⁿ` — the geometric (thermal) occupation law
  in ratio parametrization, and `geometricOccupancy_eq_thermalProb` identifying
  it with `ChapterCoherentTemperature.thermalProb` at mean `n̄ = r/(1-r)`;
* `geometricOccupancy_tsum_one` — it is a probability law on `ℕ`;
* `geometricOccupancy_mean` — its mean occupation is `r/(1-r)`;
* `geometricOccupancy_variance` — its variance is `r/(1-r)²`, equivalently
  `n̄ + n̄²` at `n̄ = r/(1-r)`;
* `half_integer_floor` — the harmonic-oscillator energy expectation
  `Σₙ (n + ½)·Pr(n)` of the thermal law is `≥ ½`, with equality exactly at the
  vacuum `n̄ = 0`: the extra `½` is a floor no thermal state can go below;
* `thermal_temperature_eq_mean_half` — **headline**: for every `x > 0`,
  `½·coth(x/2) = (Σₙ n·Pr(n)) + ½`, so the physically parametrized temperature
  is the mean occupation plus the zero-point half;
* `thermal_temperature_eq_energy_expectation_coth` — the same closed form read as
  the expectation of the energy observable `n + ½`.

**Recorded disparity with the informal chapter (unchanged).**  The derivation of
`τ` from the quantum *fidelity* of displaced thermal states on Fock space remains
outside this toolchain; what is proved here is the statistical/algebraic identity
`½·coth(x/2) = n̄(x) + ½` together with the moment structure it rests on.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterThermalTemperatureCore

open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

/-! ## The geometric occupation law in ratio parametrization -/

/-- The **geometric (thermal) occupation law** written through its ratio:
`Pr(n) = (1 - r)·rⁿ`.  For `r = n̄/(n̄+1)` this is
`ChapterCoherentTemperature.thermalProb`. -/
def geometricOccupancy (r : ℝ) (n : ℕ) : ℝ := (1 - r) * r ^ n

variable {r : ℝ}

theorem geometricOccupancy_nonneg (h0 : 0 ≤ r) (h1 : r < 1) (n : ℕ) :
    0 ≤ geometricOccupancy r n :=
  mul_nonneg (by linarith) (pow_nonneg h0 n)

/-- The mean of the ratio-`r` geometric law, `n̄ = r/(1-r)`. -/
def geometricMean (r : ℝ) : ℝ := r / (1 - r)

theorem geometricMean_nonneg (h0 : 0 ≤ r) (h1 : r < 1) : 0 ≤ geometricMean r :=
  div_nonneg h0 (by linarith)

/-- The two parametrizations agree: the geometric law of ratio `r` is the thermal
law of mean occupation `r/(1-r)`. -/
theorem geometricOccupancy_eq_thermalProb (h0 : 0 ≤ r) (h1 : r < 1) (n : ℕ) :
    geometricOccupancy r n = thermalProb (geometricMean r) n := by
  have h1' : (0 : ℝ) < 1 - r := by linarith
  have hratio : thermalRatio (geometricMean r) = r := by
    rw [thermalRatio, geometricMean]
    field_simp
    ring
  rw [thermalProb, hratio, geometricOccupancy, geometricMean]
  congr 1
  field_simp
  ring

theorem norm_lt_one_of_lt_one (h0 : 0 ≤ r) (h1 : r < 1) : ‖r‖ < 1 := by
  rw [Real.norm_eq_abs, abs_of_nonneg h0]; exact h1

/-- The geometric occupation law is a probability law on `ℕ`. -/
theorem geometricOccupancy_tsum_one (h0 : 0 ≤ r) (h1 : r < 1) :
    ∑' n : ℕ, geometricOccupancy r n = 1 := by
  rw [tsum_congr (geometricOccupancy_eq_thermalProb h0 h1)]
  exact thermalProb_tsum_one (geometricMean_nonneg h0 h1)

/-- **The mean occupation of the geometric law is `r/(1-r)`.** -/
theorem geometricOccupancy_mean (h0 : 0 ≤ r) (h1 : r < 1) :
    ∑' n : ℕ, (n : ℝ) * geometricOccupancy r n = r / (1 - r) := by
  have hcongr : ∀ n : ℕ, (n : ℝ) * geometricOccupancy r n
      = (n : ℝ) * thermalProb (geometricMean r) n := fun n => by
    rw [geometricOccupancy_eq_thermalProb h0 h1]
  rw [tsum_congr hcongr, thermalProb_mean (geometricMean_nonneg h0 h1), geometricMean]

/-- **The variance of the geometric law is `r/(1-r)²`** — equivalently `n̄ + n̄²`
at `n̄ = r/(1-r)`: strictly above the Poissonian variance `n̄` of a coherent
state. -/
theorem geometricOccupancy_variance (h0 : 0 ≤ r) (h1 : r < 1) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * geometricOccupancy r n)
      - (∑' n : ℕ, (n : ℝ) * geometricOccupancy r n) ^ 2 = r / (1 - r) ^ 2 := by
  have h1' : (0 : ℝ) < 1 - r := by linarith
  have hc2 : ∀ n : ℕ, (n : ℝ) ^ 2 * geometricOccupancy r n
      = (n : ℝ) ^ 2 * thermalProb (geometricMean r) n := fun n => by
    rw [geometricOccupancy_eq_thermalProb h0 h1]
  have hc1 : ∀ n : ℕ, (n : ℝ) * geometricOccupancy r n
      = (n : ℝ) * thermalProb (geometricMean r) n := fun n => by
    rw [geometricOccupancy_eq_thermalProb h0 h1]
  rw [tsum_congr hc2, tsum_congr hc1,
    thermalProb_variance (geometricMean_nonneg h0 h1), geometricMean]
  field_simp
  ring

/-! ## The zero-point floor -/

/-- **The Heisenberg floor of the extra `½`.**  The expectation of the
harmonic-oscillator energy observable `n + ½` in a thermal state is never below
`½`, and equals `½` exactly at the vacuum `n̄ = 0`.  This is what the additive
half in `τ = n̄ + ½` measures: the zero-point energy a coherent state cannot
give up. -/
theorem half_integer_floor {nbar : ℝ} (h : 0 ≤ nbar) :
    1 / 2 ≤ (∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n) ∧
      ((∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n) = 1 / 2 ↔ nbar = 0) := by
  rw [thermalOccupation_energy h]
  constructor
  · linarith
  · constructor
    · intro hEq; linarith
    · intro hEq; rw [hEq]; ring

/-- The same floor for a *coherent* state: its energy expectation `λ + ½` is at
least `½`. -/
theorem half_integer_floor_coherent {lam : ℝ} (h : 0 ≤ lam) :
    1 / 2 ≤ ∑' n : ℕ, ((n : ℝ) + 1 / 2) * coherentOccupation lam n := by
  rw [coherentOccupation_energy]
  linarith

/-! ## The headline: the closed form is the mean plus a half -/

/-- **Headline (Part F.4).**  For every physical inverse temperature `x > 0` the
Bose–Einstein closed form `τ(x) = ½·coth(x/2)` equals the *mean occupation* of
the thermal law plus the zero-point half.  This is the identity `τ = n̄ + ½` read
off the physical parametrization instead of being posited as a definition. -/
theorem thermal_temperature_eq_mean_half {x : ℝ} (hx : 0 < x) :
    Real.cosh (x / 2) / (2 * Real.sinh (x / 2))
      = (∑' n : ℕ, (n : ℝ) * thermalProb (boseEinstein x) n) + 1 / 2 := by
  rw [← thermalTemperature_boseEinstein_eq_coth hx, boseEinstein_mean hx, thermalTemperature]

/-- The same closed form read as the expectation of the energy observable
`n + ½` in the thermal state at inverse temperature `x`. -/
theorem thermal_temperature_eq_energy_expectation_coth {x : ℝ} (hx : 0 < x) :
    Real.cosh (x / 2) / (2 * Real.sinh (x / 2))
      = ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb (boseEinstein x) n := by
  rw [thermalOccupation_energy (le_of_lt (boseEinstein_pos hx)),
    ← thermalTemperature_boseEinstein_eq_coth hx, thermalTemperature]

end BookProof.ChapterThermalTemperatureCore

end
