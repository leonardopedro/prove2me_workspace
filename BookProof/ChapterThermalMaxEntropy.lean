import Mathlib
import BookProof.ChapterCoherentTemperature
import BookProof.ChapterCoherentOccupation
import BookProof.ChapterBoseEinstein

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

/-- The pointwise Gibbs inequality `p·log q - p·log p ≤ q - p`, a repackaging of
`log y ≤ y - 1`; it also holds (trivially) at `p = 0`. -/
theorem gibbs_pointwise (h : 0 < nbar) {p : ℝ} (hp : 0 ≤ p) (n : ℕ) :
    p * Real.log (thermalProb nbar n) - p * Real.log p ≤ thermalProb nbar n - p := by
  rcases eq_or_lt_of_le hp with hp0 | hp0
  · simp [← hp0, (thermalProb_pos h n).le]
  · have hq := thermalProb_pos h n
    have hlog : Real.log (thermalProb nbar n / p) ≤ thermalProb nbar n / p - 1 :=
      Real.log_le_sub_one_of_pos (div_pos hq hp0)
    have hsplit : Real.log (thermalProb nbar n / p)
        = Real.log (thermalProb nbar n) - Real.log p := Real.log_div (ne_of_gt hq) (ne_of_gt hp0)
    have hmul := mul_le_mul_of_nonneg_left hlog hp
    rw [hsplit] at hmul
    have hfield : p * (thermalProb nbar n / p - 1) = thermalProb nbar n - p := by field_simp
    nlinarith [hmul]

/-- **Maximum entropy at fixed mean occupation.**  Among all (finitely supported)
occupation distributions on the oscillator levels with mean occupation `n̄`, the
thermal law maximizes the Shannon entropy — this is why the bath in the chapter
is a *thermal* bath. -/
theorem shannonEntropy_le_thermalEntropy (h : 0 < nbar) (s : Finset ℕ) (p : ℕ → ℝ)
    (hp : ∀ n ∈ s, 0 ≤ p n) (hsum : ∑ n ∈ s, p n = 1)
    (hmean : ∑ n ∈ s, (n : ℝ) * p n = nbar) :
    -∑ n ∈ s, p n * Real.log (p n) ≤ thermalEntropy nbar := by
  have h0 : (0 : ℝ) ≤ nbar := le_of_lt h
  have sP := thermalProb_summable h0
  have hqsum : ∑ n ∈ s, thermalProb nbar n ≤ 1 := by
    have := sP.sum_le_tsum s (fun n _ => thermalProb_nonneg h0 n)
    rwa [thermalProb_tsum_one h0] at this
  have hstep : ∑ n ∈ s, (p n * Real.log (thermalProb nbar n) - p n * Real.log (p n))
      ≤ ∑ n ∈ s, (thermalProb nbar n - p n) :=
    Finset.sum_le_sum fun n hn => gibbs_pointwise h (hp n hn) n
  rw [Finset.sum_sub_distrib, Finset.sum_sub_distrib, hsum] at hstep
  have hcross : ∑ n ∈ s, p n * Real.log (thermalProb nbar n)
      = -Real.log (nbar + 1) + Real.log (thermalRatio nbar) * nbar := by
    have hterm : ∀ n ∈ s, p n * Real.log (thermalProb nbar n)
        = (-Real.log (nbar + 1)) * p n + Real.log (thermalRatio nbar) * ((n : ℝ) * p n) := by
      intro n _; rw [log_thermalProb h n]; ring
    rw [Finset.sum_congr rfl hterm, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum,
      hsum, hmean]
    ring
  rw [hcross] at hstep
  rw [thermalEntropy_eq h]
  linarith

end BookProof.ChapterThermalMaxEntropy

end
