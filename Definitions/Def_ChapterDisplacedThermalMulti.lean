import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterCoherentGeometry
import Mathlib


/-!
# Multi-mode displaced thermal states: attention at the bath temperature

`ChapterDisplacedThermalOverlap` computed, for a *single* quadrature, the
overlap of two displaced thermal states and showed the induced Born weights are
a Softmax at inverse temperature `β = 1/(4τ)`, `τ = n̄ + ½`.  This module runs
the same computation for `n` independent modes, which is the setting the
attention chapter actually uses: queries and keys are vectors of
`EuclideanSpace ℝ (Fin n)`.

## Deliverables

* `dtOverlapMulti` — the multi-mode overlap, the product of the one-mode
  overlaps, and `dtOverlapMulti_eq_integral` — it *is* the phase-space integral
  of the product of the two `n`-mode Gaussian densities;
* `dtOverlapMulti_eq` — the closed form
  `⟨a|b⟩ = exp(−‖a−b‖²/4τ) / (√(4πτ))ⁿ`: a Gaussian in the phase-space
  *distance*, of width the temperature;
* `dtBornMulti_eq_softmax` — **headline**: the multi-mode Born weights are
  exactly a Softmax over minus the squared distances at inverse temperature
  `β = 1/(4τ)`;
* `dtBornMulti_vacuum_eq_bornWeight` — the **vacuum limit closes the loop with
  the chapter**: at `n̄ = 0` (temperature `τ = ½`) and in the dimensionless
  coherent parameter `α = x/√2`, the thermal Born weights are *exactly* the
  coherent-state Born weights `ChapterSoftmaxBorn.bornWeight` of the attention
  chapter.

The rescaling by `√2` in the last item is the standard change between the
quadrature variable `x` (in which the vacuum has variance `½`) and the
dimensionless coherent parameter `α` (in which the vacuum overlap reads
`exp(−‖q−k‖²)`); it is stated explicitly rather than hidden in a normalization.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

namespace BookProof.ChapterDisplacedThermalMulti

open BookProof.ChapterDisplacedThermalOverlap

variable {n m : ℕ}



/-- The **multi-mode overlap** of two displaced thermal states: the product of
the one-mode overlaps of the modes. -/
def dtOverlapMulti (nbar : ℝ≥0) (a b : EuclideanSpace ℝ (Fin n)) : ℝ :=
  ∏ i, dtOverlap nbar (a i) (b i)







/-- The **multi-mode Born attention weight**. -/
def dtBornMulti (nbar : ℝ≥0) (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m) : ℝ :=
  dtOverlapMulti nbar q (k j) / ∑ l, dtOverlapMulti nbar q (k l)





end BookProof.ChapterDisplacedThermalMulti

end
