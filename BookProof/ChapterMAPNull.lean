import Mathlib

/-!
# MAP points are null under an atomless posterior

This file formalizes the next self-contained claim in the Bayesian discussion of
`book.tex` around lines 1713--1720.  The book observes that, on a continuous
sample space, a maximum of the posterior has null measure: posterior sampling
may land near such a point, but almost surely does not land exactly there.

The measure-theoretic content does not depend on how the maximizer was selected.
Under an atomless measure every singleton is null, every countable collection of
maximizers is null, and a random posterior sample almost surely avoids it.
-/

open MeasureTheory

namespace BookProof.ChapterMAPNull

variable {α : Type*} [MeasurableSpace α]

/-
Every selected MAP point has posterior mass zero under an atomless posterior.
-/
theorem map_point_measure_zero (μ : Measure α) [NoAtoms μ] (mapPoint : α) :
    μ {mapPoint} = 0 := by
  exact measure_singleton mapPoint

/-
A posterior sample almost surely does not equal a fixed MAP point.
-/
theorem ae_ne_map_point (μ : Measure α) [NoAtoms μ] (mapPoint : α) :
    ∀ᵐ x ∂μ, x ≠ mapPoint := by
  convert MeasureTheory.measure_eq_zero_iff_ae_notMem.mp
    ( map_point_measure_zero μ mapPoint ) using 1

/-
More generally, any countable collection of posterior maximizers is null.
-/
theorem countable_map_set_measure_zero (μ : Measure α) [NoAtoms μ]
    (maximizers : Set α) (hcountable : maximizers.Countable) :
    μ maximizers = 0 := by
  exact hcountable.measure_zero μ

/-- The set of global maximizers of a posterior score. -/
def maximizerSet (score : α → ℝ) : Set α :=
  {x | ∀ y, score y ≤ score x}

/-
A countable set of posterior-score maximizers is null under an atomless posterior.
-/
theorem maximizerSet_measure_zero (μ : Measure α) [NoAtoms μ]
    (score : α → ℝ) (hcountable : (maximizerSet score).Countable) :
    μ (maximizerSet score) = 0 := by
  convert countable_map_set_measure_zero μ ( maximizerSet score ) hcountable

/-
A posterior sample almost surely avoids every point in a countable MAP set.
-/
theorem ae_not_mem_countable_map_set (μ : Measure α) [NoAtoms μ]
    (maximizers : Set α) (hcountable : maximizers.Countable) :
    ∀ᵐ x ∂μ, x ∉ maximizers := by
  convert countable_map_set_measure_zero μ maximizers hcountable using 1;
  rw [ MeasureTheory.measure_eq_zero_iff_ae_notMem ]
end BookProof.ChapterMAPNull
