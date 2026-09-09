import BookProof.PhysMehler

/-!
# Kopperman model-theoretic headlines

Readable restatements of the separability and standard-arithmetic invariance
properties already proved in `BookProof.PhysMehler`.  Full infinitary
`L_{ω₁,ω₁}` completeness and compactness are not asserted: they require a syntax,
semantics, and proof calculus not present in the repository.
-/

namespace BookProof.ChapterKopperman

open PhysMehler

/-- Every model of the repository's `Formalism` carries a separable Hilbert
space, directly from the model data. -/
theorem all_formalism_models_separable {H : Type*}
    [NormedAddCommGroup H] [InnerProductSpace ℝ H] [CompleteSpace H]
    [MeasurableSpace H] (F : Formalism H) : TopologicalSpace.SeparableSpace H := by
  exact F.separable

/-- The concrete Kopperman substrate is separable. -/
theorem kopperman_substrate_separable : TopologicalSpace.SeparableSpace Substrate := by
  exact substrate_separable

/-- Truth of a standard `Π⁰₂` sentence is independent of the chosen formalism
model and foundation parameter. -/
theorem standard_pi02_truth_invariant {H : Type*}
    [NormedAddCommGroup H] [InnerProductSpace ℝ H] [CompleteSpace H]
    [MeasurableSpace H] (p : ℕ → ℕ → Bool)
    (F₁ F₂ : Formalism H) (z₁ z₂ : ZFSet) :
    interpPi02 p F₁ z₁ ↔ interpPi02 p F₂ z₂ := by
  exact arith_truth_invariant p F₁ F₂ z₁ z₂

end BookProof.ChapterKopperman
