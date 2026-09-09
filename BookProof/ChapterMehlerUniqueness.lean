import Mathlib
import BookProof.ChapterSolovayCoordinates

/-!
# The Mehler law is the unique law with standard Gaussian finite marginals

The Solovay–Kopperman chapter argues that the decidable cylindrical language can
observe *only* the finite-dimensional marginals of a law on `ℕ → ℝ`, and that the
Mehler measure (the countable product of standard Gaussians) is therefore the
*only* law available to it.  `BookProof.ChapterSolovayCoordinates` supplies the
admissibility half — `finiteCoordinateMarginal`, the statement that the Mehler
law restricts to the standard Gaussian product on every finite coordinate set.

This file supplies the forcing half:

* HEADLINE `mehler_unique_by_finite_marginals` — a probability law on `ℕ → ℝ`
  whose every finite-coordinate marginal is the standard Gaussian product **is**
  the Mehler law;
* `mehler_characterization` — the two halves packaged as a characterization;
* `language_blind_implies_mehler` — the forcing statement in the form the chapter
  uses it: if the cylindrical language cannot tell a law apart from the Mehler law
  (every finite-coordinate observable has the same expectation), the law *is* the
  Mehler law;
* `solovay_kopperman_probability_classification` — heads carry an arbitrary law,
  the tail carries only the Mehler law.

The proof is the uniqueness of a projective limit of finite measures
(`MeasureTheory.IsProjectiveLimit.unique`): cylinder sets form a π-system
generating the product σ-algebra, and the two laws agree on it.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterMehlerUniqueness

open BookProof.ChapterSolovayCoordinates

/-- **Headline.**  A law on `ℕ → ℝ` all of whose finite-coordinate marginals are
the standard Gaussian product is the Mehler coordinate law.  Hence a language that
can only observe finite coordinate sets has no choice of prior on the tail. -/
theorem mehler_unique_by_finite_marginals (nu : Measure (ℕ → ℝ))
    (h : ∀ I : Finset ℕ, nu.map I.restrict = Measure.pi (fun _ : I => standardGaussian)) :
    nu = coordinateTailMeasure :=
  MeasureTheory.IsProjectiveLimit.unique h (fun I => finiteCoordinateMarginal I)

/-- The characterization of the Mehler law by its finite marginals: a measure on
`ℕ → ℝ` has standard Gaussian marginals on every finite coordinate set **iff** it
is the Mehler law. -/
theorem mehler_characterization (nu : Measure (ℕ → ℝ)) :
    (∀ I : Finset ℕ, nu.map I.restrict = Measure.pi (fun _ : I => standardGaussian)) ↔
      nu = coordinateTailMeasure := by
  constructor
  · exact mehler_unique_by_finite_marginals nu
  · rintro rfl
    exact fun I => finiteCoordinateMarginal I

/-- If the cylindrical language cannot distinguish a law from the Mehler law —
every finite-coordinate observable has the same expectation under both — then the
marginals agree on the finite coordinate set `I`. -/
theorem map_restrict_eq_of_blind (mu : Measure CoordinateTail) [IsProbabilityMeasure mu]
    (I : Finset ℕ)
    (h : ∀ f : (I → ℝ) → ℝ,
      ∫ x, f (I.restrict x) ∂mu = ∫ x, f (I.restrict x) ∂coordinateTailMeasure) :
    mu.map I.restrict = coordinateTailMeasure.map I.restrict := by
  have hmeas : Measurable (I.restrict : CoordinateTail → (I → ℝ)) := by fun_prop
  ext s hs
  have hsm : AEStronglyMeasurable (Set.indicator s (fun _ => (1 : ℝ)))
      (mu.map I.restrict) := ((measurable_indicator_const_iff 1).2 hs).aestronglyMeasurable
  have hsm' : AEStronglyMeasurable (Set.indicator s (fun _ => (1 : ℝ)))
      (coordinateTailMeasure.map I.restrict) :=
    ((measurable_indicator_const_iff 1).2 hs).aestronglyMeasurable
  have key := h (Set.indicator s (fun _ => (1 : ℝ)))
  rw [← integral_map hmeas.aemeasurable hsm, ← integral_map hmeas.aemeasurable hsm',
    integral_indicator_const _ hs, integral_indicator_const _ hs] at key
  simp only [smul_eq_mul, mul_one] at key
  have h1 : (mu.map I.restrict) s ≠ ⊤ := measure_ne_top _ _
  have h2 : (coordinateTailMeasure.map I.restrict) s ≠ ⊤ := measure_ne_top _ _
  rwa [measureReal_def, measureReal_def, ENNReal.toReal_eq_toReal_iff' h1 h2] at key

/-- **The forcing statement.**  A law on the coordinate tail that the cylindrical
language cannot distinguish from the Mehler law *is* the Mehler law. -/
theorem language_blind_implies_mehler (mu : Measure CoordinateTail) [IsProbabilityMeasure mu]
    (h_blind : ∀ (I : Finset ℕ) (f : (I → ℝ) → ℝ),
      ∫ x, f (I.restrict x) ∂mu = ∫ x, f (I.restrict x) ∂coordinateTailMeasure) :
    mu = coordinateTailMeasure := by
  refine mehler_unique_by_finite_marginals mu fun I => ?_
  rw [map_restrict_eq_of_blind mu I (h_blind I)]
  exact finiteCoordinateMarginal I

/-- **The Solovay–Kopperman probability classification.**  On the tensor-product
coordinate space the finite head carries an *arbitrary* probability law, while the
infinite tail carries *only* the Mehler law: any product state whose tail is
language-indistinguishable from the Mehler tail is the canonical state measure. -/
theorem solovay_kopperman_probability_classification (N : ℕ)
    (headDist : Measure (Fin N → ℝ)) [IsProbabilityMeasure headDist]
    (nu : Measure CoordinateTail) [IsProbabilityMeasure nu]
    (h_blind : ∀ (I : Finset ℕ) (f : (I → ℝ) → ℝ),
      ∫ x, f (I.restrict x) ∂nu = ∫ x, f (I.restrict x) ∂coordinateTailMeasure) :
    headDist.prod nu = coordinateStateMeasure N headDist := by
  rw [language_blind_implies_mehler nu h_blind, coordinateStateMeasure]

end BookProof.ChapterMehlerUniqueness
