import Mathlib
import BookProof.ChapterAtomicDecomposition

/-!
# Mixed priors versus continuous priors

`book.tex` lines 8677–8786 (chapter *"Selecting events is not rewriting the
history of events"*, §"worst-case vs best-case prior measures") argues:

> *any mixed prior measure contains a part where it is continuous; rescaling that
> part to a probability measure yields a continuous measure whose results cannot
> be reproduced by any mixed (discrete) measure.*

Using the atomic/continuous splitting of
`BookProof.ChapterAtomicDecomposition`, this file proves the precise core of that
argument:

* `IsPurelyAtomic` — a measure is purely atomic when its continuous part
  vanishes, i.e. the atoms carry all the mass;
* `eq_zero_of_noAtoms_of_isPurelyAtomic` — a measure that is both atomless and
  purely atomic is the zero measure;
* HEADLINE `atomless_prior_not_purelyAtomic` — hence an atomless probability
  measure is **never** purely atomic: a continuous prior cannot be reproduced by
  a discrete one;
* `noAtoms_normalizedContinuousPart` and
  `isProbabilityMeasure_normalizedContinuousPart` — rescaling the continuous part
  of a mixed prior (conditioning on the complement of the atoms) yields a genuine
  *continuous* probability measure, which by the headline is out of reach of every
  purely atomic prior.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterMixedPrior

open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

/-- A measure is **purely atomic** when its atoms carry all of its mass, i.e. the
continuous part of the atomic/continuous splitting vanishes. -/
def IsPurelyAtomic (mu : Measure X) : Prop := mu (atoms mu)ᶜ = 0

omit [MeasurableSingletonClass X] in
/-- A purely atomic measure has vanishing continuous part. -/
theorem continuousPart_eq_zero_of_isPurelyAtomic {mu : Measure X} (h : IsPurelyAtomic mu) :
    continuousPart mu = 0 :=
  Measure.restrict_eq_zero.2 h

omit [MeasurableSingletonClass X] in
/-- The atom set of an atomless measure is empty. -/
theorem atoms_eq_empty_of_noAtoms (mu : Measure X) [NoAtoms mu] : atoms mu = ∅ := by
  ext x
  simp only [atoms, Set.mem_setOf_eq, measure_singleton x, lt_self_iff_false,
    Set.mem_empty_iff_false]

omit [MeasurableSingletonClass X] in
/-- **A measure cannot be both atomless and purely atomic unless it is zero.** -/
theorem eq_zero_of_noAtoms_of_isPurelyAtomic (mu : Measure X) [NoAtoms mu]
    (h : IsPurelyAtomic mu) : mu = 0 := by
  have huniv : mu Set.univ = 0 := by
    rw [IsPurelyAtomic, atoms_eq_empty_of_noAtoms mu, Set.compl_empty] at h
    exact h
  exact Measure.measure_univ_eq_zero.mp huniv

omit [MeasurableSingletonClass X] in
/-- **Headline.**  A continuous (atomless) probability measure is never purely
atomic: no discrete/mixed prior can reproduce it. -/
theorem atomless_prior_not_purelyAtomic (mu : Measure X) [IsProbabilityMeasure mu] [NoAtoms mu] :
    ¬ IsPurelyAtomic mu := by
  intro h
  have hzero := eq_zero_of_noAtoms_of_isPurelyAtomic mu h
  have : (1 : ENNReal) = 0 := by rw [← measure_univ (μ := mu), hzero]; simp
  exact one_ne_zero this

omit [MeasurableSingletonClass X] in
/-- Equivalently: a purely atomic probability measure has at least one atom. -/
theorem exists_atom_of_isPurelyAtomic (mu : Measure X) [IsProbabilityMeasure mu]
    (h : IsPurelyAtomic mu) : (atoms mu).Nonempty := by
  by_contra hempty
  rw [Set.not_nonempty_iff_eq_empty] at hempty
  rw [IsPurelyAtomic, hempty, Set.compl_empty] at h
  have : (1 : ENNReal) = 0 := by rw [← measure_univ (μ := mu)]; exact h
  exact one_ne_zero this

/-- The **rescaled continuous part** of a prior: condition on the complement of the
atoms.  This is the book's "rescale the continuous piece to a probability
measure". -/
noncomputable def normalizedContinuousPart (mu : Measure X) : Measure X :=
  mu[|(atoms mu)ᶜ]

/-- Rescaling the continuous part yields an **atomless** measure. -/
theorem noAtoms_normalizedContinuousPart (mu : Measure X) [SFinite mu] :
    NoAtoms (normalizedContinuousPart mu) := by
  have hcont : NoAtoms (continuousPart mu) := noAtoms_continuousPart mu
  constructor
  intro x
  have : normalizedContinuousPart mu {x}
      = (mu (atoms mu)ᶜ)⁻¹ * (continuousPart mu) {x} := by
    rw [normalizedContinuousPart, cond_apply' (measurableSet_singleton x), continuousPart,
      Measure.restrict_apply (measurableSet_singleton x), Set.inter_comm]
  rw [this, measure_singleton x, mul_zero]

omit [MeasurableSingletonClass X] in
/-- Rescaling the continuous part of a *mixed* prior — one that is not purely
atomic — yields a genuine probability measure. -/
theorem isProbabilityMeasure_normalizedContinuousPart (mu : Measure X)
    [IsFiniteMeasure mu] (h : ¬ IsPurelyAtomic mu) :
    IsProbabilityMeasure (normalizedContinuousPart mu) :=
  cond_isProbabilityMeasure h

/-- **The book's conclusion.**  From any mixed prior (a probability measure that is
not purely atomic) one extracts a continuous probability measure — its rescaled
continuous part — which no purely atomic prior can reproduce. -/
theorem exists_continuous_prior_beyond_atomic (mu : Measure X) [IsProbabilityMeasure mu]
    (h : ¬ IsPurelyAtomic mu) :
    ∃ nu : Measure X, IsProbabilityMeasure nu ∧ NoAtoms nu ∧ ¬ IsPurelyAtomic nu := by
  haveI := isProbabilityMeasure_normalizedContinuousPart mu h
  haveI := noAtoms_normalizedContinuousPart mu
  exact ⟨normalizedContinuousPart mu, inferInstance, inferInstance,
    atomless_prior_not_purelyAtomic _⟩

end BookProof.ChapterMixedPrior
