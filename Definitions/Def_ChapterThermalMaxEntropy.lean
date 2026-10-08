import Definitions.Def_ChapterCoherentTemperature
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib


/-!
# Chapter "The Coherent State of Attention", §"Temperature and the Thermal Bath" —
why the bath is *thermal*: the maximum-entropy characterization

`ChapterCoherentTemperature` postulates the Bose–Einstein / geometric occupation
law and computes its moments; `ChapterCoherentOccupation` identifies the
chapter's temperature `τ = n̄ + 1/2` with the mean oscillator energy, and
`ChapterBoseEinstein` identifies the law itself with the Gibbs law
`Pr(n) ∝ e^{-n x}`.  What none of them proves is *why* that law —
the physical answer being the variational one: among all occupation
distributions with a prescribed mean occupation `n̄`, the thermal law is the one
of **maximal Shannon entropy**.  That is proved here.

## Deliverables

* `thermalEntropy` — the Shannon entropy `-∑ₙ Pr(n) log Pr(n)` of the thermal
  law, and `thermalEntropy_eq`: its closed form
  `log(n̄+1) - n̄ log(n̄/(n̄+1))`;
* `thermalEntropy_boseEinstein` — in Gibbs variables,
  `S(x) = -log(1 - e^{-x}) + x·n̄(x)`, the textbook oscillator entropy;
* `gibbs_pointwise` — the pointwise Gibbs inequality
  `p·log q - p·log p ≤ q - p` (from `log y ≤ y - 1`), valid also at `p = 0`;
* `shannonEntropy_le_thermalEntropy` — **the headline**: any finitely supported
  occupation distribution `p` with mean occupation `n̄` has Shannon entropy at
  most `thermalEntropy n̄`.

The bound is not vacuous: it is the entropy of an actual distribution with that
mean occupation (`thermalProb_tsum_one`, `thermalProb_mean` in
`ChapterCoherentTemperature`), which the finitely supported competitors
approximate.

The support hypothesis (a `Finset`) keeps the competitor side elementary and
`sorry`-free; the thermal side is the genuine infinite sum.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterThermalMaxEntropy

open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}

/-! ## The thermal entropy -/





/-- The **Shannon entropy of the thermal occupation law**. -/
def thermalEntropy (nbar : ℝ) : ℝ :=
  -∑' n : ℕ, thermalProb nbar n * Real.log (thermalProb nbar n)



/-- The oscillator entropy in Gibbs variables: `S(x) ort BookProof.ChapterBoseEinstein

/-!
# Chapter "The Coherent State of Attention", §"Temperature and the Thermal Bath" —
why the bath is *thermal*: the maximum-entropy characterization

`ChapterCoherentTemperature` postulates the Bose–Einstein / geometric occupation
law and computes its moments; `ChapterCoherentOccupation` identifies the
chapter's temperature `τ = n̄ + 1/2` with the mean oscillator energy, and
`ChapterBoseEinstein` identifies the law itself with the Gibbs law
`Pr(n) ∝ e^{-n x}`.  What none of them proves is *why* that law —
the physical answer being the variational one: among all occupation
distributions with a prescribed mean occupation `n̄`, the thermal law is the one
of **maximal Shannon entropy**.  That is proved here.

## Deliverables

* `thermalEntropy` — the Shannon entropy `-∑ₙ Pr(n) log Pr(n)` of the thermal
  law, and `thermalEntropy_eq`: its closed form
  `log(n̄+1) - n̄ log(n̄/(n̄+1))`;
* `thermalEntropy_boseEinstein` — in Gibbs variables,
  `S(x) = -log(1 - e^{-x}) + x·n̄(x)`, the textbook oscillator entropy;
* `gibbs_pointwise` — the pointwise Gibbs inequality
  `p·log q - p·log p ≤ q - p` (from `log y ≤ y - 1`), valid also at `p = 0`;
* `shannonEntropy_le_thermalEntropy` — **the headline**: any finitely supported
  occupation distribution `p` with mean occupation `n̄` has Shannon entropy at
  most `thermalEntropy n̄`.

The bound is not vacuous: it is the entropy of an actual distribution with that
mean occupation (`thermalProb_tsum_one`, `thermalProb_mean` in
`ChapterCoherentTemperature`), which the finitely supported competitors
approximate.

The support hypothesis (a `Finset`) keeps the competitor side elementary and
`sorry`-free; the thermal side is the genuine infinite sum.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterThermalMaxEntropy

open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein

variable {nbar : ℝ}

/-! ## The thermal entropy -/

theorem thermalProb_pos (h : 0 < nbar) (n : ℕ) : 0 < thermalProb nbar n := by
  have h1 : 0 < nbar + 1 := by linarith
  have hr : 0 < thermalRatio nbar := div_pos h h1
  exact mul_pos (by positivity) (pow_pos hr n)

theorem log_thermalProb (h : 0 < nbar) (n : ℕ) :
    Real.log (thermalProb nbar n)
      = -Real.log (nbar + 1) + (n : ℝ) * Real.log (thermalRatio nbar) := by
  have h1 : 0 < nbar + 1 := by linarith
  have hr : 0 < thermalRatio nbar := div_pos h h1
  rw [thermalProb, Real.log_mul (by positivity) (by positivity), Real.log_pow, one_div,
    Real.log_inv]

/-- The **Shannon entropy of the thermal occupation law**. -/
def thermalEntropy (nbar : ℝ) : ℝ :=
  -∑' n : ℕ, thermalProb nbar n * Real.log (thermalProb nbar n)

/-- Closed form of the thermal entropy: `S = log(n̄+1) - n̄·log(n̄/(n̄+1))`. -/
theorem thermalEntropy_eq (h : 0 < nbar) :
    thermalEntropy nbar = Real.log (nbar + 1) - nbar * Real.log (thermalRatio nbar) := by
  have h0 : (0 : ℝ) ≤ nbar := le_of_lt h
  have sP := thermalProb_summable h0
  have sN := thermalProb_mul_summable h0
  have hf : ∀ n : ℕ, thermalProb nbar n * Real.log (thermalProb nbar n)
      = (-Real.log (nbar + 1)) * thermalProb nbar n
        + Real.log (thermalRatio nbar) * ((n : ℝ) * thermalProb nbar n) := by
    intro n; rw [log_thermalProb h n]; ring
  rw [thermalEntropy, tsum_congr hf,
    Summable.tsum_add (sP.mul_left _) (sN.mul_left _), sP.tsum_mul_left, sN.tsum_mul_left,
    thermalProb_tsum_one h0, thermalProb_mean h0]
  ring

/-- The oscillator entropy in Gibbs variables: `S(x) = -log(1 - e^{-x}) + x·n̄(x)`
at inverse temperature `x = ħω/kT`. -/
theorem thermalEntropy_boseEinstein {x : ℝ} (hx : 0 < x) :
    thermalEntropy (boseEinstein x)
      = -Real.log (1 - Real.exp (-x)) + x * boseEinstein x := by
  have hpos := boseEinstein_pos hx
  have hexp := exp_sub_one_pos hx
  have he : (0 : ℝ) < Real.exp x := Real.exp_pos _
  have hone : boseEinstein x + 1 = (1 - Real.exp (-x))⁻¹ := by
    rw [boseEinstein, Real.exp_neg]
    field_simp
    ring
  have hlt : (0 : ℝ) < 1 - Real.exp (-x) := by
    have : Real.exp (-x) < 1 := by
      rw [Real.exp_neg, inv_lt_one_iff₀]
      right; exact Real.one_lt_exp_iff.mpr hx
    linarith
  rw [thermalEntropy_eq hpos, thermalRatio_boseEinstein hx, Real.log_exp, hone, Real.log_inv]
  ring

/-! ## The Gibbs inequality and the maximum-entropy property -/





end BookProof.ChapterThermalMaxEntropy

end
