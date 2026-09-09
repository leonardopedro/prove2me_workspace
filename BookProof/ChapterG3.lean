import Mathlib
import BookProof.ChapterG
import BookProof.PhysHSGaussian

/-!
# Chapter G III — commutative von Neumann algebra, Mehler = uniform measure,
incomplete unconstrained gauge-fixing, Haar invariantization, QFT vacuum

This file formalizes work-package **G.18–G.22** of `FORMALIZATION_ROADMAP.md`
(the "Chapter G extension (Mehler measure)"), the last self-contained gauge-
theory claims of the book's gauge-symmetry chapter (`book.tex` lines 1426–1441
and 2329–2488).

Sections:
* **G.18** the algebraic measure theory: events ↔ projections of a *commutative*
  algebra (`book.tex` 1426–1441). Intersection/union of events is represented by
  products/sums of the associated idempotent projections, the algebra is
  commutative, and the state is the linear functional assigning to each
  projection its probability.
* **G.19** the Mehler prior = the uniform measure of a high-dimensional sphere
  (`book.tex` 2488, 3845). It is a probability measure, invariant under the
  orthogonal (gauge) group, and concentrated on the sphere of radius `√k`.
  Reuses the sorry-free Mehler formalism of `BookProof.PhysHSGaussian`.
* **G.20** the incomplete unconstrained gauge-fixing: the remnant gauge symmetry
  is a *faithful* (hence non-trivial) representation, and a non-trivial gauge
  transformation of a *free* remnant action modifies every point of the spectrum
  (`book.tex` 2329–2348).
* **G.21** Haar invariantization: averaging a probability measure over a finite
  gauge group produces a gauge-invariant probability measure (`book.tex`
  2371–2390).
* **G.22** the QFT vacuum: the free-field Gaussian ("Gaussian measure for the
  position and velocity", `book.tex` 2488) is a probability measure invariant
  under the orthogonal gauge group.

Everything is `sorry`-free and `axiom`-free (no `EXTERNAL` hypothesis).
-/

open MeasureTheory
open scoped ENNReal

namespace BookProof.ChapterG3

/-! ## G.18 — Algebraic measure theory: events as projections of a commutative algebra

`book.tex` 1426–1441: every commutative von Neumann algebra on a separable
Hilbert space is isomorphic to `L^∞(X,μ)`; the boolean algebra of events is
represented inside this *commutative* algebra by self-adjoint idempotent
projections, with intersection/union represented by products/sums and the state
by a linear functional assigning a probability to each projection. -/

variable {X : Type*}

/-- The projection representing an event `A` inside the commutative function
algebra `X → ℝ` (the algebraic-measure-theory picture of `book.tex` 1426). -/
noncomputable def eventProj (A : Set X) : X → ℝ := A.indicator 1

/-- Projections are idempotent (`P² = P`): they are genuine projections. -/
theorem eventProj_idem (A : Set X) : eventProj A * eventProj A = eventProj A := by
  funext x; by_cases h : x ∈ A <;> simp [eventProj, Set.indicator, h]

/-- The commutative-algebra property: the event projections commute. -/
theorem eventProj_comm (A B : Set X) :
    eventProj A * eventProj B = eventProj B * eventProj A := by
  ring

/-- Intersection of events is represented by the product of projections. -/
theorem eventProj_inter (A B : Set X) :
    eventProj (A ∩ B) = eventProj A * eventProj B := by
  funext x; by_cases hA : x ∈ A <;> by_cases hB : x ∈ B <;>
    simp [eventProj, Set.indicator, hA, hB]

/-- The complement of an event is represented by `1 - P`. -/
theorem eventProj_compl (A : Set X) :
    eventProj Aᶜ = 1 - eventProj A := by
  funext x; by_cases h : x ∈ A <;>
    simp [eventProj, Set.indicator, Pi.sub_apply, h]

/-- Union of events is represented by inclusion–exclusion of the projections. -/
theorem eventProj_union (A B : Set X) :
    eventProj (A ∪ B) = eventProj A + eventProj B - eventProj A * eventProj B := by
  funext x; by_cases hA : x ∈ A <;> by_cases hB : x ∈ B <;>
    simp [eventProj, Set.indicator, Pi.add_apply, Pi.sub_apply, Pi.mul_apply, hA, hB]

/-- The state is the linear functional that assigns to each projection its
probability: integrating the projection of `A` against a probability measure
returns `μ A` (`book.tex` 1436–1441). -/
theorem integral_eventProj [MeasurableSpace X] (μ : Measure X)
    [IsProbabilityMeasure μ] (A : Set X) (hA : MeasurableSet A) :
    ∫ x, eventProj A x ∂μ = (μ A).toReal := by
  rw [eventProj, MeasureTheory.integral_indicator_one hA, MeasureTheory.measureReal_def]

/-! ## G.19 — The Mehler prior is the uniform measure of a high-dimensional sphere

`book.tex` 2488, 3845: the prior is the "uniform measure of an infinite-
dimensional sphere". We reuse the sorry-free Mehler formalism of
`BookProof.PhysHSGaussian`: `sphereUniform k` is a probability measure, invariant
under every orthogonal (gauge) transformation, and concentrated on the sphere of
radius `√k`. -/

/-- The Mehler/uniform sphere prior is a probability measure. -/
theorem mehler_uniform_isProbability (k : ℕ) :
    IsProbabilityMeasure (PhysHSGaussian.sphereUniform k) :=
  PhysHSGaussian.sphereUniform_isProbability k

/-- HEADLINE: the Mehler/uniform sphere prior is invariant under the orthogonal
(gauge) group — the constant "Haar" measure on the sphere (`book.tex` 2371). -/
theorem mehler_uniform_gauge_invariant (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (PhysHSGaussian.sphereUniform k).map L = PhysHSGaussian.sphereUniform k :=
  PhysHSGaussian.sphereUniform_rotation_invariant k L

/-- The Mehler/uniform prior concentrates on the sphere of radius `√k`
(Poincaré–Borel; `book.tex` 3845). -/
theorem mehler_uniform_concentrates (k : ℕ) (hk : 0 < k) :
    PhysHSGaussian.sphereUniform k {x | ‖x‖ = Real.sqrt k} = 1 :=
  PhysHSGaussian.sphereUniform_sphere k hk

/-! ## G.20 — Incomplete unconstrained gauge-fixing: faithful remnant symmetry

`book.tex` 2329–2348: an incomplete unconstrained gauge-fixing retains a
*remnant* gauge symmetry that is a *faithful* (thus non-trivial) representation
of the original gauge group, and "any non-trivial gauge transformation
necessarily modifies any point of the spectrum". -/

/-- The remnant gauge symmetry is non-trivial: a faithful action of a non-trivial
group moves some point of the spectrum. -/
theorem faithful_remnant_nontrivial {G Y : Type*} [Group G] [MulAction G Y]
    [FaithfulSMul G Y] [Nontrivial G] : ∃ (g : G) (y : Y), g • y ≠ y := by
  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  by_contra h
  push_neg at h
  exact hg (eq_of_smul_eq_smul (fun y => by rw [one_smul]; exact h g y))

/-- "Any non-trivial gauge transformation necessarily modifies any point of the
spectrum": for a *free* remnant action, every non-identity gauge element moves
every point. -/
theorem free_remnant_moves_every_point {G Y : Type*} [Group G] [MulAction G Y]
    (hfree : ∀ (g : G) (y : Y), g • y = y → g = 1) {g : G} (hg : g ≠ 1) (y : Y) :
    g • y ≠ y := fun h => hg (hfree g y h)

/-! ## G.21 — Haar invariantization: averaging over a finite gauge group

`book.tex` 2371–2390: "a constant measure (Haar measure) always exists which
allows to create a functional which is gauge invariant". For a finite gauge
group we build the invariantized measure explicitly by averaging the pushforwards
of a probability measure over all group elements; the result is a gauge-invariant
probability measure. -/

/-- The Haar-invariantization of a measure `μ` by a finite gauge group `G`: the
average of the pushforwards `μ.map (g • ·)` over all `g`. -/
noncomputable def averagedMeasure (G : Type*) [Group G] [Fintype G]
    {Z : Type*} [MeasurableSpace Z] [MulAction G Z] (μ : Measure Z) : Measure Z :=
  (Fintype.card G : ℝ≥0∞)⁻¹ • ∑ g : G, μ.map (fun x => g • x)

/-- The Haar-averaged measure is again a probability measure. -/
theorem averagedMeasure_isProbability (G : Type*) [Group G] [Fintype G]
    {Z : Type*} [MeasurableSpace Z] [MulAction G Z]
    (hmeas : ∀ g : G, Measurable (fun x : Z => g • x))
    (μ : Measure Z) [IsProbabilityMeasure μ] :
    IsProbabilityMeasure (averagedMeasure G μ) := by
  constructor
  rw [averagedMeasure, Measure.smul_apply, Measure.finset_sum_apply]
  have h1 : ∀ g : G, (μ.map (fun x => g • x)) Set.univ = 1 := by
    intro g
    rw [Measure.map_apply (hmeas g) MeasurableSet.univ]
    simp
  simp only [h1]
  rw [Finset.sum_const, Finset.card_univ, smul_eq_mul, nsmul_eq_mul, mul_one,
    ENNReal.inv_mul_cancel]
  · exact_mod_cast (Fintype.card_pos).ne'
  · exact ENNReal.natCast_ne_top _

/-- HEADLINE: the Haar-averaged measure is gauge-invariant — it is fixed by the
pushforward action of every group element. -/
theorem averagedMeasure_invariant (G : Type*) [Group G] [Fintype G]
    {Z : Type*} [MeasurableSpace Z] [MulAction G Z]
    (hmeas : ∀ g : G, Measurable (fun x : Z => g • x))
    (μ : Measure Z) (h : G) :
    (averagedMeasure G μ).map (fun x => h • x) = averagedMeasure G μ := by
  rw [averagedMeasure, Measure.map_smul]
  congr 1
  have hmap : Measure.map (fun x => h • x) (∑ g : G, μ.map (fun x => g • x))
      = ∑ g : G, Measure.map (fun x => h • x) (μ.map (fun x => g • x)) := by
    rw [← Measure.mapₗ_apply_of_measurable (hmeas h), map_sum]
    apply Finset.sum_congr rfl
    intro g _
    rw [Measure.mapₗ_apply_of_measurable (hmeas h)]
  rw [hmap, ← Equiv.sum_comp (Equiv.mulLeft h) (fun g => μ.map (fun x => g • x))]
  apply Finset.sum_congr rfl
  intro g _
  rw [Measure.map_map (hmeas h) (hmeas g)]
  congr 1
  ext x
  simp [mul_smul, Equiv.mulLeft]

/-! ## G.22 — The QFT vacuum is the gauge-invariant Gaussian

`book.tex` 2488: the vacuum is described by the "Gaussian measure for the
position and (unconstrained) velocity". The free-field vacuum is the standard
Gaussian on the configuration space, a probability measure invariant under the
orthogonal gauge group. -/

/-- The free-field QFT vacuum: the standard Gaussian on the `k`-dimensional
field-configuration space (`book.tex` 2488). -/
noncomputable def qftVacuum (k : ℕ) : Measure (EuclideanSpace ℝ (Fin k)) :=
  PhysHSGaussian.gaussianE k

/-- The QFT vacuum is a probability measure. -/
theorem qftVacuum_isProbability (k : ℕ) : IsProbabilityMeasure (qftVacuum k) :=
  PhysHSGaussian.gaussianE_isProbability k

/-- HEADLINE: the QFT vacuum is invariant under the orthogonal gauge group. -/
theorem qftVacuum_gauge_invariant (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (qftVacuum k).map L = qftVacuum k :=
  PhysHSGaussian.gaussianE_rotation_invariant k L

end BookProof.ChapterG3
