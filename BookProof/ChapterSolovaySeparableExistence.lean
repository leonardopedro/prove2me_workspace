import Mathlib
import BookProof.ChapterSolovay
import BookProof.ChapterSolovayCoordinates
import BookProof.ChapterSolovayTailDimension

/-!
# The Introduction's question, answered: a separable law with an arbitrary finite
part; wave-functions for finite joint laws; product disintegration
(plan §4.4, §4.5, §4.6)

Three small, self-contained closers of the Solovay–Kopperman programme.

## Deliverables

* **§4.4 — `joint_prob_has_wavefunction`.**  Every finite joint probability law is
  `|Ψ|²` for a wave-function: given `p ≥ 0` on a finite type with `∑ p = 1` there
  is `Ψ` with `‖Ψ z‖² = p z` and `∑ ‖Ψ z‖² = 1`.  `joint_prob_has_wavefunction_prod`
  is the two-variable form, in which the marginal of `|Ψ|²` in the first variable
  is the marginal of `p`;
* **§4.5 — `exists_separable_prob_with_arbitrary_finite_law`.**  The Introduction's
  problem: a *separable* probability space carrying an **arbitrary** law on the
  finite head and the (forced) Mehler law on the infinite tail, with the correct
  finite marginal.  Stated both in the coordinate model
  (`CoordinateSpace N = (Fin N → ℝ) × (ℕ → ℝ)`) and in the abstract substrate model
  (`InnerSpace N = InnerHead N × InnerTail`), together with the separability of both
  carriers.  The tail factor is genuinely infinite dimensional
  (`ChapterSolovayTailDimension.tail_infinite_dimensional`), so the construction is
  not a finite-dimensional artefact;
* **§4.6 — `prod_disintegration`.**  The explicit `joint = marginal ⊗ₘ kernel` form
  of disintegration on a standard Borel second factor, the companion of the
  `condDistrib` route used in `ChapterSelectingEvents`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

noncomputable section

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterSolovaySeparableExistence

open BookProof.ChapterSolovayCoordinates

/-! ## §4.4 — Every finite joint law is `|Ψ|²` -/

/-- **A finite joint probability law is the squared modulus of a wave-function.**
Given a probability vector `p` on a finite type, the pointwise square root is a
wave-function whose Born probabilities are exactly `p`. -/
theorem joint_prob_has_wavefunction {Z : Type*} [Fintype Z] (p : Z → ℝ)
    (hp : ∀ z, 0 ≤ p z) (hsum : ∑ z, p z = 1) :
    ∃ Ψ : Z → ℂ, (∀ z, ‖Ψ z‖ ^ 2 = p z) ∧ ∑ z, ‖Ψ z‖ ^ 2 = 1 := by
  refine ⟨fun z => (Real.sqrt (p z) : ℂ), fun z => ?_, ?_⟩
  · rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _),
      Real.sq_sqrt (hp z)]
  · rw [← hsum]
    refine Finset.sum_congr rfl fun z _ => ?_
    rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _),
      Real.sq_sqrt (hp z)]

/-- The two-variable form: a joint law `p(x,y)` on a finite product is `|Ψ|²`, and
the `x`-marginal of the Born probabilities is the `x`-marginal of `p`. -/
theorem joint_prob_has_wavefunction_prod {X Y : Type*} [Fintype X] [Fintype Y]
    (p : X × Y → ℝ) (hp : ∀ z, 0 ≤ p z) (hsum : ∑ z, p z = 1) :
    ∃ Ψ : X × Y → ℂ, (∀ z, ‖Ψ z‖ ^ 2 = p z) ∧ ∑ z, ‖Ψ z‖ ^ 2 = 1 ∧
      ∀ x : X, (∑ y : Y, ‖Ψ (x, y)‖ ^ 2) = ∑ y : Y, p (x, y) := by
  obtain ⟨Ψ, hΨ, hΨsum⟩ := joint_prob_has_wavefunction p hp hsum
  exact ⟨Ψ, hΨ, hΨsum, fun x => Finset.sum_congr rfl fun y _ => hΨ (x, y)⟩

/-! ## §4.5 — A separable probability space with an arbitrary finite law -/

/-- The coordinate carrier is separable: a finite head times a countable product of
copies of `ℝ`. -/
theorem coordinateSpace_separable (N : ℕ) :
    TopologicalSpace.SeparableSpace (CoordinateSpace N) := by
  infer_instance

/-- The abstract carrier is separable: the finite head times the Kopperman
substrate `L²([0,1])`. -/
theorem innerSpace_separable (N : ℕ) :
    TopologicalSpace.SeparableSpace (_root_.InnerSpace N) := by
  haveI := PhysMehler.substrate_separable
  infer_instance

/-- **Headline (plan §4.5), coordinate model.**  For *any* probability law on the
finite head there is a probability measure on the separable carrier
`(Fin N → ℝ) × (ℕ → ℝ)` whose head marginal is that law and whose tail marginal is
the Mehler (standard Gaussian coordinate) law. -/
theorem exists_separable_prob_with_arbitrary_finite_law (N : ℕ)
    (headDist : Measure (Fin N → ℝ)) [IsProbabilityMeasure headDist] :
    TopologicalSpace.SeparableSpace (CoordinateSpace N) ∧
      ∃ μ : Measure (CoordinateSpace N), IsProbabilityMeasure μ ∧
        Measure.map Prod.fst μ = headDist ∧
        Measure.map Prod.snd μ = coordinateTailMeasure := by
  refine ⟨coordinateSpace_separable N, coordinateStateMeasure N headDist, inferInstance, ?_, ?_⟩
  · rw [coordinateStateMeasure, Measure.map_fst_prod, measure_univ, one_smul]
  · rw [coordinateStateMeasure, Measure.map_snd_prod, measure_univ, one_smul]

/-- **Headline (plan §4.5), abstract model.**  The same statement for the
substrate tail: a separable carrier, an arbitrary head law, the Mehler/Kopperman
tail prior, and the correct finite marginal. -/
theorem exists_separable_prob_with_arbitrary_finite_law_substrate (N : ℕ)
    (headDist : Measure (_root_.InnerHead N)) [IsProbabilityMeasure headDist] :
    TopologicalSpace.SeparableSpace (_root_.InnerSpace N) ∧
      ∃ μ : Measure (_root_.InnerSpace N), IsProbabilityMeasure μ ∧
        Measure.map Prod.fst μ = headDist ∧
        Measure.map Prod.snd μ = _root_.tailMeasure := by
  refine ⟨innerSpace_separable N, _root_.stateMeasure N headDist, inferInstance, ?_, ?_⟩
  · rw [_root_.stateMeasure, Measure.map_fst_prod, measure_univ, one_smul]
  · rw [_root_.stateMeasure, Measure.map_snd_prod, measure_univ, one_smul]

/-- The infinite factor of the construction really is infinite dimensional, so the
answer to the Introduction's question is not a finite-dimensional artefact. -/
theorem separable_carrier_tail_infinite_dimensional :
    ¬ FiniteDimensional ℝ _root_.InnerTail :=
  BookProof.ChapterSolovayTailDimension.tail_infinite_dimensional

/-! ## §4.6 — Disintegration in explicit product form -/

/-- **Product disintegration (plan §4.6).**  Every finite measure on a product with
standard Borel second factor is its own first marginal composed with a Markov
kernel: `μ = μ.fst ⊗ₘ κ`.  This is the explicit `prod_disintegrate` companion of
the `condDistrib` route used in `ChapterSelectingEvents`. -/
theorem prod_disintegration {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
    [StandardBorelSpace Y] [Nonempty Y] (μ : Measure (X × Y)) [IsFiniteMeasure μ] :
    ∃ κ : Kernel X Y, IsMarkovKernel κ ∧ μ.fst ⊗ₘ κ = μ :=
  ⟨μ.condKernel, inferInstance, Measure.disintegrate μ μ.condKernel⟩

/-- The disintegration applied to the Solovay state space: the joint law of a head
and a coordinate tail is the head marginal composed with a Markov kernel. -/
theorem coordinateState_disintegration (N : ℕ) (μ : Measure (CoordinateSpace N))
    [IsFiniteMeasure μ] :
    ∃ κ : Kernel (Fin N → ℝ) CoordinateTail, IsMarkovKernel κ ∧ μ.fst ⊗ₘ κ = μ :=
  prod_disintegration μ

end BookProof.ChapterSolovaySeparableExistence

end
