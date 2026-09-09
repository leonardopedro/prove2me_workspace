import Mathlib

/-!
# Chapter (§10 "Ensemble forecasting …") — There is no uniform countable measure

This file formalizes the foundational measure-theoretic claim that `book.tex`
uses to motivate the need for a *standard* (uncountable, continuous) probability
space in its ensemble-forecasting section (§10 "Ensemble forecasting allows the
approximation of a non-linear infinite-dimensional model …", `book.tex`
line ~2005):

> "There is no uniform countable measure. Thus, the rationals are not enough for
> Probability Theory. A standard probability space (which has countable and
> continuous measures) seems irreducible."

The precise mathematical statement is: on a *countably infinite* measurable
space with measurable singletons there is **no probability measure that assigns
the same mass to every singleton** (a "uniform" measure). Indeed, if every
singleton had common mass `c`, then countable additivity would give total mass
`∑' _, c`, which is `0` when `c = 0` and `⊤` when `c ≠ 0` — never `1`.

## Deliverables

- `no_uniform_countable_measure` — the headline: for an infinite countable
  measurable space with measurable singletons there is no probability measure
  giving all singletons a common value `c`.
- `no_uniform_measure_nat` — the book's concrete instance on `ℕ` (the "rationals
  are not enough" remark): no probability measure on `ℕ` is uniform on
  singletons.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open MeasureTheory
open scoped ENNReal

namespace BookProof.ChapterNoUniformCountable

/-- **No uniform countable measure.**  On a countably infinite measurable space
with measurable singletons, no probability measure assigns a common value `c` to
every singleton.  This is the content behind the book's assertion that "the
rationals are not enough for Probability Theory". -/
theorem no_uniform_countable_measure
    {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] [Countable α]
    [Infinite α] (μ : Measure α) [IsProbabilityMeasure μ] (c : ℝ≥0∞)
    (h : ∀ a, μ {a} = c) : False := by
  -- Total mass is the sum of the singleton masses (countable additivity).
  have huniv : μ Set.univ = ∑' a : α, μ {a} := by
    have := MeasureTheory.Measure.tsum_indicator_apply_singleton μ Set.univ MeasurableSet.univ
    simpa using this.symm
  -- Substitute the common value and use that `μ` is a probability measure.
  rw [show (∑' a : α, μ {a}) = ∑' _a : α, c by simp_rw [h]] at huniv
  rcases eq_or_ne c 0 with hc | hc
  · -- If the common mass is `0`, the total mass is `0 ≠ 1`.
    simp [hc] at huniv
  · -- If the common mass is nonzero, the total mass is `⊤ ≠ 1`.
    rw [ENNReal.tsum_const_eq_top_of_ne_zero hc] at huniv
    simp at huniv

/-- The book's concrete instance: **there is no uniform probability measure on
`ℕ`**.  No probability measure on the natural numbers gives every singleton the
same mass.  ("Thus, the rationals are not enough for Probability Theory.") -/
theorem no_uniform_measure_nat
    (μ : Measure ℕ) [IsProbabilityMeasure μ] (c : ℝ≥0∞)
    (h : ∀ n : ℕ, μ {n} = c) : False :=
  no_uniform_countable_measure μ c h

end BookProof.ChapterNoUniformCountable
