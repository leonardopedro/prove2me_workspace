import Mathlib

/-!
# Probability as a universal language: transport along a Markov kernel

`book.tex` (~8402, ~8702) argues that probability is a *universal language*: any
mechanism which turns a state `x` into a distribution over answers — that is, a
Markov (conditional-probability) kernel `κ : X → Measure Y` — transports a prior
on `X` into a genuine posterior/predictive distribution on `Y`, and nothing is
lost or created in the process (the total mass stays `1`).

This module proves that finite, precise core:

* `kernel_transport_isProbability` — the transport `μ.bind κ` of a probability
  measure along a Markov kernel is again a probability measure;
* `kernel_transport_apply` — its value on a measurable set is the average
  `∫⁻ x, κ x s ∂μ` of the kernel values (the law of total probability);
* `kernel_transport_lintegral` — expectations under the transported law are
  averages of the conditional expectations;
* `map_transport_isProbability` — the deterministic special case: pushing a
  probability measure forward along a measurable map gives a probability measure;
* `kernel_transport_deterministic` — the deterministic kernel `Kernel.deterministic f`
  transports `μ` exactly to `μ.map f`, so deterministic transport is the special
  case of kernel transport.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterKernelTransport

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]

/-- **Kernel transport preserves probability.**  A Markov kernel carries a
probability measure to a probability measure. -/
theorem kernel_transport_isProbability (kappa : Kernel X Y) [IsMarkovKernel kappa]
    (mu : Measure X) [IsProbabilityMeasure mu] :
    IsProbabilityMeasure (mu.bind kappa) := by
  constructor
  rw [Measure.bind_apply MeasurableSet.univ kappa.aemeasurable]
  simp

/-- **Law of total probability.**  The transported measure of a measurable set is
the `μ`-average of the conditional probabilities. -/
theorem kernel_transport_apply (kappa : Kernel X Y) (mu : Measure X)
    {s : Set Y} (hs : MeasurableSet s) :
    (mu.bind kappa) s = ∫⁻ x, kappa x s ∂mu :=
  Measure.bind_apply hs kappa.aemeasurable

/-- Expectations under the transported law are averages of conditional
expectations. -/
theorem kernel_transport_lintegral (kappa : Kernel X Y) (mu : Measure X)
    [SFinite mu] [IsSFiniteKernel kappa] {f : Y → ENNReal} (hf : Measurable f) :
    ∫⁻ y, f y ∂(mu.bind kappa) = ∫⁻ x, (∫⁻ y, f y ∂(kappa x)) ∂mu :=
  Measure.lintegral_bind kappa.aemeasurable hf.aemeasurable

/-- The deterministic special case: a measurable map transports a probability
measure to a probability measure. -/
theorem map_transport_isProbability (f : X → Y) (hf : Measurable f)
    (mu : Measure X) [IsProbabilityMeasure mu] :
    IsProbabilityMeasure (mu.map f) :=
  Measure.isProbabilityMeasure_map hf.aemeasurable

/-- Deterministic transport is a special case of kernel transport: the
deterministic kernel attached to a measurable map `f` transports `μ` to `μ.map f`. -/
theorem kernel_transport_deterministic (f : X → Y) (hf : Measurable f)
    (mu : Measure X) [SFinite mu] :
    mu.bind (Kernel.deterministic f hf) = mu.map f := by
  ext s hs
  rw [kernel_transport_apply _ _ hs, Measure.map_apply hf hs]
  simp only [Kernel.deterministic_apply' hf _ hs]
  rw [show (fun x => s.indicator (fun _ => (1 : ENNReal)) (f x))
      = (f ⁻¹' s).indicator (fun _ => (1 : ENNReal)) from by
        ext x; by_cases h : f x ∈ s <;> simp [Set.indicator, h, Set.mem_preimage],
    lintegral_indicator (hf hs)]
  simp

end BookProof.ChapterKernelTransport
