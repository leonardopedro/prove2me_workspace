import Mathlib

/-!
# Chapter "Wave-function collapse versus Euler's formula", §"Euler's formula for
a generic phase-space" — a positive-measure partition of the phase space is
countable

Source: `book.tex`, chapter *"Wave-function collapse versus Euler's formula"*,
§*"Euler's formula for a generic phase-space"* (`book.tex` line ~3570):

> *"A continuous probability distribution is a probability distribution that has
> a cumulative distribution function that is continuous. Thus, any partition of
> the phase-space (where each part of the phase-space has a non-null Lebesgue
> measure) is countable."*

The book uses this fact to justify indexing the parts of a phase-space partition
by a countable orthonormal basis `{lₙ}` of a *separable* Hilbert space, on which
the recursive Euler-angle (stick-breaking) wave-function parametrization of
`ChapterEulerNState` is built.  The underlying mathematical statement is a
standard measure-theoretic fact, entirely independent of the surrounding
physics: in an s-finite (in particular, any probability) measure space, a family
of pairwise-disjoint measurable sets can contain **at most countably many** sets
of positive measure; hence a genuine *partition* into positive-measure parts is
indexed by a countable set.

This complements `ChapterNoUniformCountable` (there is no uniform countable
measure) and `ChapterNoLebesgue` (no infinite-dimensional Lebesgue measure):
together they pin down the book's assertion that "a mixed standard probability
space (with countable and continuous measures) is unavoidable".

## Deliverables

* `countable_of_partition_pos` — **core**: for an s-finite measure `μ`, if
  `As : ι → Set α` are pairwise disjoint, measurable, and *every* part has
  positive measure, then the index type `ι` is countable.
* `setCountable_of_partition_pos` — the same phrased for a set `P` of subsets
  forming a positive-measure partition: `P.Countable`.
* `exists_measure_zero_of_uncountable` — the contrapositive: an *uncountable*
  family of pairwise-disjoint measurable sets must contain a null part.
* `prob_partition_countable` — the specialization to a probability measure (the
  book's "phase-space" case): a positive-measure partition is countable.
* `prob_partition_countable_tsum_one` — for a probability measure, a
  positive-measure partition that *covers* the space is countable and its part
  probabilities sum to `1` (countable additivity of the total probability).
* `partition_real_volume_countable` — the book's literal statement: a partition
  of the real line `ℝ` into parts of non-null Lebesgue measure is countable.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory
open scoped ENNReal

namespace BookProof.ChapterCountablePartition

variable {α : Type*} {ι : Type*} {m : MeasurableSpace α} {μ : Measure α}

/-- **Core result.** In an s-finite measure space, if `As : ι → Set α` is a
family of pairwise-disjoint measurable sets, *each* of positive measure, then
the index type `ι` is countable.  This is the book's *"any partition of the
phase-space (where each part has non-null measure) is countable"*. -/
theorem countable_of_partition_pos [SFinite μ] {As : ι → Set α}
    (hmeas : ∀ i, MeasurableSet (As i)) (hdisj : Pairwise (Function.onFun Disjoint As))
    (hpos : ∀ i, 0 < μ (As i)) : Countable ι := by
  have h := Measure.countable_meas_pos_of_disjoint_iUnion (μ := μ) hmeas hdisj
  have hset : {i | 0 < μ (As i)} = Set.univ := by ext i; simp [hpos i]
  rw [hset] at h
  exact Set.countable_univ_iff.mp h

/-- Set-indexed form: a set `P` of subsets that are pairwise disjoint,
measurable, and each of positive measure, is a countable set. -/
theorem setCountable_of_partition_pos [SFinite μ] {P : Set (Set α)}
    (hmeas : ∀ s ∈ P, MeasurableSet s) (hdisj : P.Pairwise Disjoint)
    (hpos : ∀ s ∈ P, 0 < μ s) : P.Countable := by
  rw [← Set.countable_coe_iff]
  refine countable_of_partition_pos (μ := μ) (As := fun s : P => (s : Set α))
    (fun s => hmeas s s.2) ?_ (fun s => hpos s s.2)
  intro s t hst
  exact hdisj s.2 t.2 (by simpa using Subtype.coe_ne_coe.mpr hst)

/-- Contrapositive: an *uncountable* family of pairwise-disjoint measurable sets
must contain a part of measure zero. -/
theorem exists_measure_zero_of_uncountable [SFinite μ] {As : ι → Set α}
    (hmeas : ∀ i, MeasurableSet (As i)) (hdisj : Pairwise (Function.onFun Disjoint As))
    (hunc : ¬ Countable ι) : ∃ i, μ (As i) = 0 := by
  by_contra h
  push_neg at h
  exact hunc (countable_of_partition_pos hmeas hdisj (fun i => (h i).bot_lt))

/-- The book's "phase-space" case: under a probability measure, a partition into
positive-measure parts is countable. -/
theorem prob_partition_countable [IsProbabilityMeasure μ] {As : ι → Set α}
    (hmeas : ∀ i, MeasurableSet (As i)) (hdisj : Pairwise (Function.onFun Disjoint As))
    (hpos : ∀ i, 0 < μ (As i)) : Countable ι :=
  countable_of_partition_pos hmeas hdisj hpos

/-- For a probability measure, a positive-measure partition that *covers* the
whole space is countable and its part probabilities sum to `1`. -/
theorem prob_partition_countable_tsum_one [IsProbabilityMeasure μ] {As : ι → Set α}
    (hmeas : ∀ i, MeasurableSet (As i)) (hdisj : Pairwise (Function.onFun Disjoint As))
    (hpos : ∀ i, 0 < μ (As i)) (hcover : ⋃ i, As i = Set.univ) :
    Countable ι ∧ ∑' i, μ (As i) = 1 := by
  have hc : Countable ι := countable_of_partition_pos hmeas hdisj hpos
  refine ⟨hc, ?_⟩
  rw [← measure_iUnion hdisj hmeas, hcover, measure_univ]

/-- The book's literal statement for the real line: a partition of `ℝ` into
parts of non-null Lebesgue measure is countable. -/
theorem partition_real_volume_countable {As : ι → Set ℝ}
    (hmeas : ∀ i, MeasurableSet (As i)) (hdisj : Pairwise (Function.onFun Disjoint As))
    (hpos : ∀ i, 0 < volume (As i)) : Countable ι :=
  countable_of_partition_pos hmeas hdisj hpos

end BookProof.ChapterCountablePartition
