import Mathlib

/-!
# Chapter "Wave-function parametrization of a probability measure", §10
*"Ensemble forecasting …"* — measurements reproduce the probability distribution
in the limit of infinitely many measurements

This file formalizes the self-contained mathematical claim of the section
*"10. Ensemble forecasting allows the approximation of a non-linear
infinite-dimensional model …"* (`book.tex` line ~2005):

> *"a measurement is applying the Bayes rule to update a probability: destroy the
> uncertainty … by converting probabilities into events, unpredictably and
> **reproducing the probability distribution in the limit of infinite
> measurements**. … It is not different from an unbiased sampling process taken
> over infinite time."*

The precise mathematical statement is the **strong law of large numbers** applied
to a (finite-outcome) measurement: if we repeat a measurement `M` — an i.i.d.
sequence of `Fin k`-valued random variables, each distributed like the physical
state being measured — then for every outcome `a` the **empirical frequency** of
`a` over the first `n` measurements,

`freqₙ(a) = (number of i < n with Mᵢ = a) / n`,

converges *almost surely*, as `n → ∞`, to the true probability of that outcome,
`ℙ(M₀ = a)`.  In other words, an infinite sequence of measurements reproduces the
probability distribution of the state, exactly as the book asserts.

## Deliverables

* `outcomeIndicator` — the `{0,1}`-valued indicator of the event "`Mᵢ = a`".
* `outcomeIndicator_integral` — its expectation is the outcome probability,
  `∫ outcomeIndicator M a 0 = (ℙ(M₀ = a)).toReal`.
* `measurement_average_tendsto` — the general real-observable version (the
  "unbiased sampling over infinite time" statement): the running average of an
  observable `f ∘ Mᵢ` tends a.s. to its expectation `𝔼[f ∘ M₀]`.
* `measurement_frequency_tendsto` — the headline: for i.i.d. measurements the
  empirical frequency of every outcome `a` tends almost surely to the outcome
  probability `(ℙ(M₀ = a)).toReal`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal

namespace BookProof.ChapterMeasurementLLN

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ]
variable {k : ℕ}

/-- The `{0,1}`-valued indicator of the measurement outcome "`Mᵢ = a`",
i.e. the observable that returns `1` when the `i`-th measurement yields outcome
`a` and `0` otherwise. -/
noncomputable def outcomeIndicator (M : ℕ → Ω → Fin k) (a : Fin k) (i : ℕ) : Ω → ℝ :=
  fun ω => if M i ω = a then (1 : ℝ) else 0

omit [IsProbabilityMeasure μ] in
/-- The expectation of the outcome indicator is the outcome probability:
`∫ outcomeIndicator M a 0 ∂μ = (μ {ω | M 0 ω = a}).toReal`. -/
theorem outcomeIndicator_integral (M : ℕ → Ω → Fin k) (a : Fin k)
    (hM : Measurable (M 0)) :
    ∫ ω, outcomeIndicator M a 0 ω ∂μ = (μ {ω | M 0 ω = a}).toReal := by
  convert MeasureTheory.integral_indicator_one
    (hM (MeasurableSingletonClass.measurableSet_singleton a))
  ext ω; simp [outcomeIndicator, Set.indicator]

/-- **Unbiased sampling over infinite time (general observable version).**
For an i.i.d. sequence of `Fin k`-valued measurements `M` (each measurable,
pairwise independent, and identically distributed to `M 0`) and any real
observable `f : Fin k → ℝ`, the running average of the observed values `f (Mᵢ ω)`
converges almost surely to the expectation `∫ f (M 0 ω) ∂μ`.  Taking `f` the
indicator of a single outcome recovers `measurement_frequency_tendsto`. -/
theorem measurement_average_tendsto (M : ℕ → Ω → Fin k) (f : Fin k → ℝ)
    (hmeas : ∀ i, Measurable (M i))
    (hindep : Pairwise (fun i j => IndepFun (M i) (M j) μ))
    (hident : ∀ i, IdentDistrib (M i) (M 0) μ μ) :
    ∀ᵐ ω ∂μ, Filter.Tendsto
      (fun n => (∑ i ∈ Finset.range n, f (M i ω)) / n)
      Filter.atTop (nhds (∫ ω, f (M 0 ω) ∂μ)) := by
  have hf : Measurable f := measurable_of_countable f
  -- Apply the strong law of large numbers to the sequence `Xᵢ = f ∘ Mᵢ`.
  refine ProbabilityTheory.strong_law_ae_real (fun i ω => f (M i ω)) ?_ ?_ ?_
  · -- `X₀ = f ∘ M₀` is bounded by `∑ x, |f x|`, hence integrable on a probability space.
    refine MeasureTheory.Integrable.mono' (integrable_const (∑ x : Fin k, |f x|)) ?_ ?_
    · exact (hf.comp (hmeas 0)).aestronglyMeasurable
    · filter_upwards with ω
      rw [Real.norm_eq_abs]
      exact Finset.single_le_sum (f := fun x => |f x|)
        (fun x _ => abs_nonneg _) (Finset.mem_univ (M 0 ω))
  · -- Pairwise independence transfers from `M` to `f ∘ M`.
    intro i j hij; exact (hindep hij).comp hf hf
  · -- Identical distribution transfers from `M` to `f ∘ M`.
    intro i; exact (hident i).comp hf

/-- **Measurements reproduce the probability distribution.**
For an i.i.d. sequence of `Fin k`-valued measurements `M` (each measurable,
pairwise independent, and identically distributed to `M 0`), the empirical
frequency of any outcome `a` over the first `n` measurements converges almost
surely, as `n → ∞`, to the true outcome probability `(μ {ω | M 0 ω = a}).toReal`.
This is the strong law of large numbers form of the book's claim that a
measurement, repeated infinitely often, reproduces the probability
distribution. -/
theorem measurement_frequency_tendsto (M : ℕ → Ω → Fin k) (a : Fin k)
    (hmeas : ∀ i, Measurable (M i))
    (hindep : Pairwise (fun i j => IndepFun (M i) (M j) μ))
    (hident : ∀ i, IdentDistrib (M i) (M 0) μ μ) :
    ∀ᵐ ω ∂μ, Filter.Tendsto
      (fun n => (∑ i ∈ Finset.range n, outcomeIndicator M a i ω) / n)
      Filter.atTop (nhds (μ {ω | M 0 ω = a}).toReal) := by
  -- Specialize the general observable version to the indicator of outcome `a`
  -- and identify its expectation with the outcome probability.
  have hint := measurement_average_tendsto M (fun b => if b = a then (1 : ℝ) else 0)
    hmeas hindep hident
  rw [← outcomeIndicator_integral M a (hmeas 0)]
  exact hint

end BookProof.ChapterMeasurementLLN
