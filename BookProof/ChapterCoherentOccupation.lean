import Mathlib
import BookProof.ChapterCoherentTemperature

/-!
# Chapter "The Coherent State of Attention", §"Temperature and the Thermal Bath" —
the occupation statistics of a coherent state

`BookProof/ChapterCoherentTemperature.lean` proves the moment structure of the
*thermal* (Bose–Einstein) occupation distribution and records the temperature
`τ = n̄ + 1/2` as a definition, with the physical derivation flagged as a gap.
Its docstring appeals twice to the *coherent* (Poisson) occupation statistics —
"the Poissonian variance `n̄` of a coherent state" and "the zero-point half".
This module proves those two statements.

What is proved:

* `coherentOccupation` — the coherent-state occupation law
  `p(n) = e^{-λ} λⁿ / n!`, i.e. Mathlib's Poisson probability mass function
  (`coherentOccupation_eq_poissonPMFReal` records the identification);
* `coherentOccupation_hasSum_one`, `coherentOccupation_tsum_one`,
  `coherentOccupation_nonneg` — it is a probability distribution on `ℕ`;
* `coherentOccupation_mean` — its mean occupation is `λ`;
* `coherentOccupation_second_moment` — its second moment is `λ² + λ`;
* `coherentOccupation_variance` — hence its variance is exactly `λ`: coherent
  light is **Poissonian**, the statement `ChapterCoherentTemperature` appeals to;
* `coherentOccupation_energy` — the mean of the harmonic-oscillator energy
  observable `n + 1/2` in a coherent state is `λ + 1/2`, the "mean occupation
  plus the zero-point half";
* `thermalOccupation_energy` and `thermalTemperature_eq_energy_expectation` — the
  same energy identity for the thermal law: the chapter's temperature
  `τ = n̄ + 1/2` **is** the expectation of `n + 1/2` in the thermal state (this
  upgrades `thermalTemperature_eq_mean_add_half` from a restatement of the
  definition to an identity for a genuine observable);
* `coherent_variance_lt_thermal_variance` — for a nonvacuum bath the coherent
  (Poisson) noise `n̄` is strictly below the thermal noise `n̄² + n̄`.

**Recorded disparity with the informal chapter (unchanged).**  What remains a
documented gap is the *physical* derivation of `τ = n̄ + 1/2` from the quantum
fidelity of displaced thermal states on a bosonic Fock space; the identity is
proved here only for the occupation statistics, i.e. as the expectation of the
number-plus-zero-point observable, not from fidelity.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterCoherentOccupation

open Real Nat ProbabilityTheory

/-! ## The exponential series -/

/-- The exponential series, as a `HasSum` statement. -/
theorem hasSum_expSeries (lam : ℝ) :
    HasSum (fun n : ℕ => lam ^ n / (n ! : ℝ)) (Real.exp lam) := by
  rw [Real.exp_eq_exp_ℝ, NormedSpace.exp_eq_tsum_div]
  exact (Real.summable_pow_div_factorial lam).hasSum

/-! ## The coherent (Poisson) occupation distribution -/

/-- The **occupation distribution of a coherent state** with mean occupation
`λ = |α|²`: the Poisson law `p(n) = e^{-λ} λⁿ / n!`. -/
def coherentOccupation (lam : ℝ) (n : ℕ) : ℝ := Real.exp (-lam) * lam ^ n / n !

/-- The coherent occupation law is Mathlib's Poisson probability mass function. -/
theorem coherentOccupation_eq_poissonPMFReal (r : NNReal) (n : ℕ) :
    coherentOccupation r n = poissonPMFReal r n := rfl

theorem coherentOccupation_eq (lam : ℝ) (n : ℕ) :
    coherentOccupation lam n = Real.exp (-lam) * (lam ^ n / (n ! : ℝ)) := by
  rw [coherentOccupation, mul_div_assoc]

theorem coherentOccupation_nonneg {lam : ℝ} (h : 0 ≤ lam) (n : ℕ) :
    0 ≤ coherentOccupation lam n := by
  rw [coherentOccupation_eq]
  positivity

/-- **The coherent occupation law is a probability distribution.** -/
theorem coherentOccupation_hasSum_one (lam : ℝ) : HasSum (coherentOccupation lam) 1 := by
  have h := (hasSum_expSeries lam).mul_left (Real.exp (-lam))
  rw [← Real.exp_add, neg_add_cancel, Real.exp_zero] at h
  exact h.congr_fun fun n => coherentOccupation_eq lam n

theorem coherentOccupation_tsum_one (lam : ℝ) : ∑' n : ℕ, coherentOccupation lam n = 1 :=
  (coherentOccupation_hasSum_one lam).tsum_eq

/-! ## Moments -/

/-- The first factorial moment of the exponential series. -/
theorem hasSum_mul_expSeries (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * (lam ^ n / (n ! : ℝ))) (lam * Real.exp lam) := by
  have key : HasSum (fun n : ℕ => ((n + 1 : ℕ) : ℝ) * (lam ^ (n + 1) / (((n + 1)! : ℕ) : ℝ)))
      (lam * Real.exp lam) := by
    refine ((hasSum_expSeries lam).mul_left lam).congr_fun ?_
    intro n
    rw [Nat.factorial_succ]
    push_cast
    field_simp
    ring
  simpa using
    (hasSum_nat_add_iff (f := fun n : ℕ => (n : ℝ) * (lam ^ n / (n ! : ℝ))) 1).mp key

/-- The second factorial moment `∑ n(n-1) λⁿ/n! = λ² e^λ` of the exponential
series. -/
theorem hasSum_fallingTwo_expSeries (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * ((n : ℝ) - 1) * (lam ^ n / (n ! : ℝ)))
      (lam ^ 2 * Real.exp lam) := by
  have key : HasSum (fun n : ℕ => ((n + 2 : ℕ) : ℝ) * (((n + 2 : ℕ) : ℝ) - 1) *
      (lam ^ (n + 2) / (((n + 2)! : ℕ) : ℝ))) (lam ^ 2 * Real.exp lam) := by
    refine ((hasSum_expSeries lam).mul_left (lam ^ 2)).congr_fun ?_
    intro n
    rw [Nat.factorial_succ, Nat.factorial_succ]
    push_cast
    field_simp
    ring
  have hshift := (hasSum_nat_add_iff
    (f := fun n : ℕ => (n : ℝ) * ((n : ℝ) - 1) * (lam ^ n / (n ! : ℝ))) 2).mp key
  simpa [Finset.sum_range_succ] using hshift

/-- **The mean occupation of a coherent state is `λ`.** -/
theorem coherentOccupation_hasSum_mean (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * coherentOccupation lam n) lam := by
  have h := (hasSum_mul_expSeries lam).mul_left (Real.exp (-lam))
  have hval : Real.exp (-lam) * (lam * Real.exp lam) = lam := by
    rw [show Real.exp (-lam) * (lam * Real.exp lam)
        = lam * (Real.exp (-lam) * Real.exp lam) by ring,
      ← Real.exp_add, neg_add_cancel, Real.exp_zero, mul_one]
  rw [hval] at h
  refine h.congr_fun fun n => ?_
  rw [coherentOccupation_eq]
  ring

theorem coherentOccupation_mean (lam : ℝ) :
    ∑' n : ℕ, (n : ℝ) * coherentOccupation lam n = lam :=
  (coherentOccupation_hasSum_mean lam).tsum_eq

/-- **The second moment of the coherent occupation law is `λ² + λ`.** -/
theorem coherentOccupation_hasSum_second_moment (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) ^ 2 * coherentOccupation lam n) (lam ^ 2 + lam) := by
  have hfall := (hasSum_fallingTwo_expSeries lam).mul_left (Real.exp (-lam))
  have hmean := coherentOccupation_hasSum_mean lam
  have hval : Real.exp (-lam) * (lam ^ 2 * Real.exp lam) = lam ^ 2 := by
    rw [show Real.exp (-lam) * (lam ^ 2 * Real.exp lam)
        = lam ^ 2 * (Real.exp (-lam) * Real.exp lam) by ring,
      ← Real.exp_add, neg_add_cancel, Real.exp_zero, mul_one]
  rw [hval] at hfall
  have hfall' : HasSum
      (fun n : ℕ => (n : ℝ) * ((n : ℝ) - 1) * coherentOccupation lam n) (lam ^ 2) := by
    refine hfall.congr_fun fun n => ?_
    rw [coherentOccupation_eq]
    ring
  refine (hfall'.add hmean).congr_fun fun n => ?_
  ring

theorem coherentOccupation_second_moment (lam : ℝ) :
    ∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation lam n = lam ^ 2 + lam :=
  (coherentOccupation_hasSum_second_moment lam).tsum_eq

/-- **Coherent light is Poissonian**: the variance of the occupation equals its
mean `λ`.  This is the statement `ChapterCoherentTemperature` compares the
thermal variance `n̄² + n̄` against. -/
theorem coherentOccupation_variance (lam : ℝ) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation lam n)
      - (∑' n : ℕ, (n : ℝ) * coherentOccupation lam n) ^ 2 = lam := by
  rw [coherentOccupation_second_moment, coherentOccupation_mean]
  ring

/-- **The energy of a coherent state.**  The harmonic-oscillator energy
observable is `n + 1/2` (in units of `ħω`); its expectation in the coherent state
of mean occupation `λ` is `λ + 1/2` — the mean occupation plus the zero-point
half. -/
theorem coherentOccupation_energy (lam : ℝ) :
    ∑' n : ℕ, ((n : ℝ) + 1 / 2) * coherentOccupation lam n = lam + 1 / 2 := by
  have h := (coherentOccupation_hasSum_mean lam).add
    ((coherentOccupation_hasSum_one lam).mul_left (1 / 2))
  rw [mul_one] at h
  exact (h.congr_fun fun n => by ring).tsum_eq

/-! ## The thermal law: the temperature is the energy expectation -/

open BookProof.ChapterCoherentTemperature

theorem thermalProb_summable {nbar : ℝ} (h : 0 ≤ nbar) :
    Summable (fun n : ℕ => thermalProb nbar n) := by
  have hr := norm_thermalRatio_lt_one h
  have hgeom : Summable (fun n : ℕ => thermalRatio nbar ^ n) :=
    summable_geometric_of_norm_lt_one hr
  exact (hgeom.mul_left (1 / (nbar + 1))).congr fun n => by rw [thermalProb]

theorem thermalProb_mul_summable {nbar : ℝ} (h : 0 ≤ nbar) :
    Summable (fun n : ℕ => (n : ℝ) * thermalProb nbar n) := by
  have hr := norm_thermalRatio_lt_one h
  have h1 : Summable (fun n : ℕ => (n : ℝ) * thermalRatio nbar ^ n) :=
    (hasSum_coe_mul_geometric_of_norm_lt_one hr).summable
  exact (h1.mul_left (1 / (nbar + 1))).congr fun n => by rw [thermalProb]; ring

/-- **The thermal energy expectation.**  The expectation of the
harmonic-oscillator energy observable `n + 1/2` in the thermal state of mean
occupation `n̄` is `n̄ + 1/2`. -/
theorem thermalOccupation_energy {nbar : ℝ} (h : 0 ≤ nbar) :
    ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n = nbar + 1 / 2 := by
  have hsplit : ∀ n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n
      = (n : ℝ) * thermalProb nbar n + (1 / 2) * thermalProb nbar n := fun n => by ring
  rw [tsum_congr hsplit,
    Summable.tsum_add (thermalProb_mul_summable h) ((thermalProb_summable h).mul_left (1 / 2)),
    (thermalProb_summable h).tsum_mul_left, thermalProb_mean h, thermalProb_tsum_one h]
  ring

/-- **The chapter's temperature is an expectation value.**  `τ = n̄ + 1/2` is the
expectation of the number-plus-zero-point observable `n + 1/2` in the thermal
state.  (The remaining, physical, step — deriving `τ` from the fidelity of
displaced thermal states — stays a documented gap.) -/
theorem thermalTemperature_eq_energy_expectation {nbar : ℝ} (h : 0 ≤ nbar) :
    thermalTemperature nbar = ∑' n : ℕ, ((n : ℝ) + 1 / 2) * thermalProb nbar n := by
  rw [thermalOccupation_energy h, thermalTemperature]

/-- **A thermal bath is noisier than a coherent state of the same mean.**  At
equal mean occupation `n̄ > 0` the coherent (Poisson) variance `n̄` is strictly
smaller than the thermal variance `n̄² + n̄`. -/
theorem coherent_variance_lt_thermal_variance {nbar : ℝ} (h : 0 < nbar) :
    ((∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation nbar n)
        - (∑' n : ℕ, (n : ℝ) * coherentOccupation nbar n) ^ 2)
      < ((∑' n : ℕ, (n : ℝ) ^ 2 * thermalProb nbar n)
        - (∑' n : ℕ, (n : ℝ) * thermalProb nbar n) ^ 2) := by
  rw [coherentOccupation_variance, thermalProb_variance h.le]
  nlinarith

end BookProof.ChapterCoherentOccupation

end
