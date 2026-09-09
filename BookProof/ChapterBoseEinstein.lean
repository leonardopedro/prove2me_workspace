import Mathlib
import BookProof.ChapterCoherentTemperature
import BookProof.ChapterCoherentOccupation

/-!
# Chapter "The Coherent State of Attention", §"Temperature and the Thermal Bath" —
the Bose–Einstein occupation and the Gibbs law

`ChapterCoherentTemperature` introduces the thermal occupation law through its
mean occupation `n̄` and proves its moments; `ChapterCoherentOccupation` shows
that the chapter's temperature `τ = n̄ + 1/2` is the expectation of the
harmonic-oscillator energy `n + 1/2` in that state
(`thermalTemperature_eq_energy_expectation`).

What was still missing is the *physical parametrization*: the law as a function
of the actual temperature.  This module supplies it.

## Deliverables

* `boseEinstein x = 1/(eˣ - 1)` — the Bose–Einstein occupation at dimensionless
  inverse temperature `x = ħω/kT`, with `boseEinstein_pos` and
  `boseEinstein_strictAntiOn` (heating raises the occupation);
* `thermalRatio_boseEinstein` — the thermal ratio becomes the Boltzmann factor
  `r = e^{-x}`;
* `thermalProb_boseEinstein` — **the thermal law is the Gibbs law**:
  `Pr(n) = (1 - e^{-x})·e^{-n x}`, the normalized Boltzmann weights of the
  oscillator levels;
* `boseEinstein_mean` — the Bose–Einstein function is exactly the mean
  occupation of that law;
* `thermalTemperature_boseEinstein`, `thermalTemperature_boseEinstein_eq_coth` —
  the textbook closed form `τ(x) = n̄(x) + 1/2 = ½·coth(x/2)`;
* `tendsto_thermalTemperature_boseEinstein` — the zero-temperature limit
  `τ → 1/2` as `x → ∞`: the pure zero-point floor of `ChapterSoftmaxBorn`.

**Documented gap (unchanged).**  The derivation of the same `τ` from the quantum
fidelity of *displaced thermal states* on Fock space remains out of reach in this
toolchain.  Nothing here is `sorry`-ed and everything is `axiom`-free (only
`propext`, `Classical.choice`, `Quot.sound`).
-/

noncomputable section

open Filter Topology

namespace BookProof.ChapterBoseEinstein

open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation

variable {x : ℝ}

/-- The **Bose–Einstein occupation** of a mode at dimensionless inverse
temperature `x = ħω/kT`: `n̄(x) = 1/(eˣ - 1)`. -/
def boseEinstein (x : ℝ) : ℝ := 1 / (Real.exp x - 1)

theorem exp_sub_one_pos (hx : 0 < x) : 0 < Real.exp x - 1 := by
  have := Real.add_one_lt_exp (ne_of_gt hx)
  linarith

theorem boseEinstein_pos (hx : 0 < x) : 0 < boseEinstein x :=
  div_pos one_pos (exp_sub_one_pos hx)

/-- The thermal ratio at Bose–Einstein occupation is the Boltzmann factor
`r = e^{-x}`. -/
theorem thermalRatio_boseEinstein (hx : 0 < x) :
    thermalRatio (boseEinstein x) = Real.exp (-x) := by
  have h := exp_sub_one_pos hx
  have he : (0 : ℝ) < Real.exp x := Real.exp_pos _
  rw [thermalRatio, boseEinstein, Real.exp_neg]
  field_simp
  ring

/-- **The thermal occupation law is the Gibbs law.**  With the Bose–Einstein
mean occupation, the level probabilities are the normalized Boltzmann weights
`Pr(n) = (1 - e^{-x})·e^{-n x}`. -/
theorem thermalProb_boseEinstein (hx : 0 < x) (n : ℕ) :
    thermalProb (boseEinstein x) n = (1 - Real.exp (-x)) * Real.exp (-x) ^ n := by
  have h := exp_sub_one_pos hx
  have he : (0 : ℝ) < Real.exp x := Real.exp_pos _
  rw [thermalProb, thermalRatio_boseEinstein hx, boseEinstein, Real.exp_neg]
  congr 1
  field_simp
  ring

/-- The Bose–Einstein function really is the mean occupation of the Gibbs law. -/
theorem boseEinstein_mean (hx : 0 < x) :
    ∑' n : ℕ, (n : ℝ) * thermalProb (boseEinstein x) n = boseEinstein x :=
  thermalProb_mean (le_of_lt (boseEinstein_pos hx))

/-- Heating the mode (decreasing `x = ħω/kT`) strictly increases the mean
occupation. -/
theorem boseEinstein_strictAntiOn : StrictAntiOn boseEinstein (Set.Ioi 0) := by
  intro a ha b _ hab
  have ha' : 0 < a := ha
  have h1 := exp_sub_one_pos ha'
  have hexp : Real.exp a < Real.exp b := Real.exp_lt_exp.mpr hab
  rw [boseEinstein, boseEinstein]
  apply one_div_lt_one_div_of_lt h1
  linarith

/-! ## The closed form of the temperature -/

theorem thermalTemperature_boseEinstein (hx : 0 < x) :
    thermalTemperature (boseEinstein x) = (Real.exp x + 1) / (2 * (Real.exp x - 1)) := by
  have h := exp_sub_one_pos hx
  rw [thermalTemperature, boseEinstein]
  field_simp
  ring

/-- **The textbook closed form.**  `τ(x) = n̄(x) + 1/2 = ½·coth(x/2)` — the mean
energy of a quantum oscillator, zero-point term included (the energy reading of
`τ` being `ChapterCoherentOccupation.thermalTemperature_eq_energy_expectation`). -/
theorem thermalTemperature_boseEinstein_eq_coth (hx : 0 < x) :
    thermalTemperature (boseEinstein x) = Real.cosh (x / 2) / (2 * Real.sinh (x / 2)) := by
  set t : ℝ := Real.exp (x / 2) with htdef
  have htpos : 0 < t := Real.exp_pos _
  have ht1 : 1 < t := by
    rw [htdef]; exact Real.one_lt_exp_iff.mpr (by linarith)
  have hsq : Real.exp x = t * t := by rw [htdef, ← Real.exp_add]; ring_nf
  have hinv : Real.exp (-(x / 2)) = t⁻¹ := by rw [htdef, Real.exp_neg]
  have hinvlt : t⁻¹ < 1 := by
    rw [inv_lt_one_iff₀]; right; exact ht1
  have hne : t - t⁻¹ ≠ 0 := by intro hc; nlinarith
  have h2 : t * t - 1 ≠ 0 := by nlinarith
  rw [thermalTemperature_boseEinstein hx, Real.cosh_eq, Real.sinh_eq, hinv, hsq]
  field_simp
  ring

/-- **The zero-temperature limit.**  As `x = ħω/kT → ∞` the temperature falls to
the pure zero-point value `1/2` — the Heisenberg floor of `ChapterSoftmaxBorn`. -/
theorem tendsto_thermalTemperature_boseEinstein :
    Tendsto (fun x : ℝ => thermalTemperature (boseEinstein x)) atTop (𝓝 (1 / 2)) := by
  have h1 : Tendsto (fun x : ℝ => Real.exp x - 1) atTop atTop :=
    Real.tendsto_exp_atTop.atTop_add tendsto_const_nhds
  have h2 : Tendsto (fun x : ℝ => boseEinstein x) atTop (𝓝 0) := by
    simpa [boseEinstein, one_div] using h1.inv_tendsto_atTop
  simpa [thermalTemperature] using h2.add (tendsto_const_nhds (x := (1 / 2 : ℝ)))

end BookProof.ChapterBoseEinstein

end
