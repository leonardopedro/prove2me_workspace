import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterCoherentOccupation
import Mathlib


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













/-! ## The closed form of the temperature -/







end BookProof.ChapterBoseEinstein

end
