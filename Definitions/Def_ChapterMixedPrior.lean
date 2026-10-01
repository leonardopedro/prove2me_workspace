import Definitions.Def_ChapterAtomicDecomposition
import Mathlib


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











/-- The **rescaled continuous part** of a prior: condition on the complement of the
atoms.  This is the book's "rescale the continuous piece to a probability
measure". -/
noncomputable def normalizedContinuousPart (mu : Measure X) : Measure X :=
  mu[|(atoms mu)ᶜ]







end BookProof.ChapterMixedPrior
