import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib


/-!
# Casimir constraints, Haar averaging and the pushforward of the constrained measure

This module formalizes the three remaining analytic claims of the section
*"Gauge transformations, constrained systems and conditioned probability"* of
`book.tex` (lines 2221–2400), which the companion modules
`BookProof.ChapterGaugeIncompleteFixing` and
`BookProof.ChapterGaugeComprehensiveFixing` do not cover.

## 1. Casimir constraints (`book.tex` 2383–2387)

> "Note that it suffices to constrain to zero the Casimir operators of the
> (eventually non-commutative) Lie algebra of constraints, this imposes the
> constraints without the need for the constraints to be part of the commutative
> von Neumann algebra, only the Casimir operators are included in the commutative
> algebra."

For symmetric (Hermitian) constraint generators `T a`, the quadratic Casimir
`C = ∑ a, T a ∘ T a` satisfies `⟪v, C v⟫ = ∑ a, ‖T a v‖²` (`inner_casimir`), so
`C v = 0` **iff** every constraint annihilates `v`
(`casimir_apply_eq_zero_iff`); equivalently `ker C = ⨅ a, ker (T a)`
(`ker_casimir`).  Constraining the single operator `C` to zero therefore imposes
all the constraints at once, exactly as the book asserts.

## 2. The Haar average produces the gauge-invariant functional (`book.tex` 2377)

> "for a locally compact gauge group (a Lie group, for instance), a constant
> measure (Haar measure) always exists which allows to create a functional which
> is gauge invariant."

`gaugeAverage μ f x = ∫ g, f (g • x) ∂μ` is a physical (gauge-invariant)
observable as soon as `μ` is right invariant (`gaugeAverage_isPhysicalObservable`),
it is normalized on the constants when `μ` is a probability measure
(`gaugeAverage_const`), and it fixes the observables that are already physical
(`gaugeAverage_of_isPhysicalObservable`) — so averaging is a projection onto the
physical algebra, and the "constrained spectrum" of gauge-invariant functionals is
never empty.  The same three facts are proved for a finite gauge group with the
normalized counting average (`finiteGaugeAverage_*`), where no integrability
hypothesis at all is needed.

Between the two, `isPhysicalObservable_of_tendsto` records the manuscript's remark
that a *gauge* symmetry can never be anomalous (`book.tex` 2389–2395): gauge
invariance of the observables survives every limit, so no symmetry-breaking
parameter can destroy it.

## 3. The pushforward implements the exact constraint without a null set
(`book.tex` 2228–2238 and 2369–2376)

> "there is still the possibility of defining the probability measure of the
> constrained space as a pushforward measure from the unconstrained to the
> constrained space" … "Then, the pushforward measure using such measurable
> function implements the exact constraints in a separable probability space
> without attributing to the constrained space null probability measure."

`map_measure_constrainedSet` : for a measurable projection `q` of the spectrum
into the constrained set `C`, the pushforward `μ.map q` gives `C` probability one
— the exact constraint holds almost surely, and the constrained space carries the
whole measure instead of being null.  `integral_map_of_invariant` : expectation
values of the observables that do not see the projection (in particular the
physical ones, when the projection moves a point only inside its gauge
equivalence class) are unchanged by the pushforward.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterGaugeCasimirAverage

open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

/-! ## 1. Casimir operator of a family of constraints -/

section Casimir

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

/-- The quadratic Casimir operator `∑ a, T a ∘ T a` of a finite family of
constraint generators `T`. -/
noncomputable def casimir (T : ι → V →ₗ[ℂ] V) : V →ₗ[ℂ] V := ∑ a, (T a) ∘ₗ (T a)g and the pushforward of the constrained measure

This module formalizes the three remaining analytic claims of the section
*"Gauge transformations, constrained systems and conditioned probability"* of
`book.tex` (lines 2221–2400), which the companion modules
`BookProof.ChapterGaugeIncompleteFixing` and
`BookProof.ChapterGaugeComprehensiveFixing` do not cover.

## 1. Casimir constraints (`book.tex` 2383–2387)

> "Note that it suffices to constrain to zero the Casimir operators of the
> (eventually non-commutative) Lie algebra of constraints, this imposes the
> constraints without the need for the constraints to be part of the commutative
> von Neumann algebra, only the Casimir operators are included in the commutative
> algebra."

For symmetric (Hermitian) constraint generators `T a`, the quadratic Casimir
`C = ∑ a, T a ∘ T a` satisfies `⟪v, C v⟫ = ∑ a, ‖T a v‖²` (`inner_casimir`), so
`C v = 0` **iff** every constraint annihilates `v`
(`casimir_apply_eq_zero_iff`); equivalently `ker C = ⨅ a, ker (T a)`
(`ker_casimir`).  Constraining the single operator `C` to zero therefore imposes
all the constraints at once, exactly as the book asserts.

## 2. The Haar average produces the gauge-invariant functional (`book.tex` 2377)

> "for a locally compact gauge group (a Lie group, for instance), a constant
> measure (Haar measure) always exists which allows to create a functional which
> is gauge invariant."

`gaugeAverage μ f x = ∫ g, f (g • x) ∂μ` is a physical (gauge-invariant)
observable as soon as `μ` is right invariant (`gaugeAverage_isPhysicalObservable`),
it is normalized on the constants when `μ` is a probability measure
(`gaugeAverage_const`), and it fixes the observables that are already physical
(`gaugeAverage_of_isPhysicalObservable`) — so averaging is a projection onto the
physical algebra, and the "constrained spectrum" of gauge-invariant functionals is
never empty.  The same three facts are proved for a finite gauge group with the
normalized counting average (`finiteGaugeAverage_*`), where no integrability
hypothesis at all is needed.

Between the two, `isPhysicalObservable_of_tendsto` records the manuscript's remark
that a *gauge* symmetry can never be anomalous (`book.tex` 2389–2395): gauge
invariance of the observables survives every limit, so no symmetry-breaking
parameter can destroy it.

## 3. The pushforward implements the exact constraint without a null set
(`book.tex` 2228–2238 and 2369–2376)

> "there is still the possibility of defining the probability measure of the
> constrained space as a pushforward measure from the unconstrained to the
> constrained space" … "Then, the pushforward measure using such measurable
> function implements the exact constraints in a separable probability space
> without attributing to the constrained space null probability measure."

`map_measure_constrainedSet` : for a measurable projection `q` of the spectrum
into the constrained set `C`, the pushforward `μ.map q` gives `C` probability one
— the exact constraint holds almost surely, and the constrained space carries the
whole measure instead of being null.  `integral_map_of_invariant` : expectation
values of the observables that do not see the projection (in particular the
physical ones, when the projection moves a point only inside its gauge
equivalence class) are unchanged by the pushforward.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterGaugeCasimirAverage

open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

/-! ## 1. Casimir operator of a family of constraints -/

section Casimir

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

/-- The quadratic Casimir operator `∑ a, T a ∘ T a` of a finite family of
constraint generators `T`. -/
noncomputable def casimir (T : ι → V →ₗ[ℂ] V) : V →ₗ[ℂ] V := ∑ a, (T a) ∘ₗ (T a)

theorem casimir_apply (T : ι → V →ₗ[ℂ] V) (v : V) :
    casimir T v = ∑ a, T a (T a v) := by
  simp [casimir, LinearMap.sum_apply]







end Casimir

/-! ## 2. Haar averaging: the gauge-invariant functional -/

section Averaging

variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]

/-- The **Haar average** of an observable over the gauge group: the book's
"functional which is gauge invariant" built from the constant (Haar) measure. -/
noncomputable def gaugeAverage (μ : Measure G) (f : X → ℝ) (x : X) : ℝ :=
  ∫ g, f (g • x) ∂μ







end Averaging

/-! ### The finite gauge group: averaging with no integrability hypothesis -/

section FiniteAveraging

variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]

/-- The normalized average of an observable over a finite gauge group. -/
noncomputable def finiteGaugeAverage (G : Type*) [Group G] [Fintype G] [MulAction G X]
    (f : X → ℝ) (x : X) : ℝ :=
  (∑ g : G, f (g • x)) / (Fintype.card G)







end FiniteAveraging

/-! ### No anomaly for a gauge symmetry (`book.tex` 2389–2395) -/

section NoAnomaly

variable {X : Type*} {G : Type*} [Group G] [MulAction G X]



end NoAnomaly

/-! ## 3. The pushforward measure implements the exact constraint -/

section Pushforward

variable {X : Type*} [MeasurableSpace X]

nditioned probability"* of
`book.tex` (lines 2221–2400), which the companion modules
`BookProof.ChapterGaugeIncompleteFixing` and
`BookProof.ChapterGaugeComprehensiveFixing` do not cover.

## 1. Casimir constraints (`book.tex` 2383–2387)

> "Note that it suffices to constrain to zero the Casimir operators of the
> (eventually non-commutative) Lie algebra of constraints, this imposes the
> constraints without the need for the constraints to be part of the commutative
> von Neumann algebra, only the Casimir operators are included in the commutative
> algebra."

For symmetric (Hermitian) constraint generators `T a`, the quadratic Casimir
`C = ∑ a, T a ∘ T a` satisfies `⟪v, C v⟫ = ∑ a, ‖T a v‖²` (`inner_casimir`), so
`C v = 0` **iff** every constraint annihilates `v`
(`casimir_apply_eq_zero_iff`); equivalently `ker C = ⨅ a, ker (T a)`
(`ker_casimir`).  Constraining the single operator `C` to zero therefore imposes
all the constraints at once, exactly as the book asserts.

## 2. The Haar average produces the gauge-invariant functional (`book.tex` 2377)

> "for a locally compact gauge group (a Lie group, for instance), a constant
> measure (Haar measure) always exists which allows to create a functional which
> is gauge invariant."

`gaugeAverage μ f x = ∫ g, f (g • x) ∂μ` is a physical (gauge-invariant)
observable as soon as `μ` is right invariant (`gaugeAverage_isPhysicalObservable`),
it is normalized on the constants when `μ` is a probability measure
(`gaugeAverage_const`), and it fixes the observables that are already physical
(`gaugeAverage_of_isPhysicalObservable`) — so averaging is a projection onto the
physical algebra, and the "constrained spectrum" of gauge-invariant functionals is
never empty.  The same three facts are proved for a finite gauge group with the
normalized counting average (`finiteGaugeAverage_*`), where no integrability
hypothesis at all is needed.

Between the two, `isPhysicalObservable_of_tendsto` records the manuscript's remark
that a *gauge* symmetry can never be anomalous (`book.tex` 2389–2395): gauge
invariance of the observables survives every limit, so no symmetry-breaking
parameter can destroy it.

## 3. The pushforward implements the exact constraint without a null set
(`book.tex` 2228–2238 and 2369–2376)

> "there is still the possibility of defining the probability measure of the
> constrained space as a pushforward measure from the unconstrained to the
> constrained space" … "Then, the pushforward measure using such measurable
> function implements the exact constraints in a separable probability space
> without attributing to the constrained space null probability measure."

`map_measure_constrainedSet` : for a measurable projection `q` of the spectrum
into the constrained set `C`, the pushforward `μ.map q` gives `C` probability one
— the exact constraint holds almost surely, and the constrained space carries the
whole measure instead of being null.  `integral_map_of_invariant` : expectation
values of the observables that do not see the projection (in particular the
physical ones, when the projection moves a point only inside its gauge
equivalence class) are unchanged by the pushforward.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterGaugeCasimirAverage

open BookProof.ChapterGaugeIncompleteFixing
open MeasureTheory
open scoped InnerProductSpace

/-! ## 1. Casimir operator of a family of constraints -/

section Casimir

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {ι : Type*} [Fintype ι]

/-- The quadratic Casimir operator `∑ a, T a ∘ T a` of a finite family of
constraint generators `T`. -/
noncomputable def casimir (T : ι → V →ₗ[ℂ] V) : V →ₗ[ℂ] V := ∑ a, (T a) ∘ₗ (T a)

theorem casimir_apply (T : ι → V →ₗ[ℂ] V) (v : V) :
    casimir T v = ∑ a, T a (T a v) := by
  simp [casimir, LinearMap.sum_apply]

/-- For Hermitian constraints, the expectation value of the Casimir operator is
the sum of the squared norms of the constraints. -/
theorem inner_casimir (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric) (v : V) :
    ⟪v, casimir T v⟫_ℂ = ((∑ a, ‖T a v‖ ^ 2 : ℝ) : ℂ) := by
  rw [casimir_apply, inner_sum]
  push_cast
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← hT a v (T a v), inner_self_eq_norm_sq_to_K]
  norm_cast

/-- **Constraining the Casimir operator to zero imposes every constraint.** For a
family of Hermitian constraint generators, a vector is annihilated by the Casimir
operator if and only if it is annihilated by each generator. -/
theorem casimir_apply_eq_zero_iff (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric)
    (v : V) : casimir T v = 0 ↔ ∀ a, T a v = 0 := by
  constructor
  · intro h
    have h0 : ((∑ a, ‖T a v‖ ^ 2 : ℝ) : ℂ) = 0 := by
      rw [← inner_casimir T hT v, h, inner_zero_right]
    have hr : (∑ a, ‖T a v‖ ^ 2 : ℝ) = 0 := by exact_mod_cast h0
    intro a
    have ha := (Finset.sum_eq_zero_iff_of_nonneg
      (fun b _ => sq_nonneg ‖T b v‖)).mp hr a (Finset.mem_univ a)
    simpa using ha
  · intro h
    rw [casimir_apply]
    simp [h]

/-- The kernel of the Casimir operator is exactly the intersection of the kernels
of the constraints: the constrained subspace. -/
theorem ker_casimir (T : ι → V →ₗ[ℂ] V) (hT : ∀ a, (T a).IsSymmetric) :
    LinearMap.ker (casimir T) = ⨅ a, LinearMap.ker (T a) := by
  ext v
  simp only [LinearMap.mem_ker, Submodule.mem_iInf]
  exact casimir_apply_eq_zero_iff T hT v

end Casimir

/-! ## 2. Haar averaging: the gauge-invariant functional -/

section Averaging

variable {X : Type*}
variable {G : Type*} [Group G] [MeasurableSpace G] [MeasurableMul G] [MulAction G X]

/-- The **Haar average** of an observable over the gauge group: the book's
"functional which is gauge invariant" built from the constant (Haar) measure. -/
noncomputable def gaugeAverage (μ : Measure G) (f : X → ℝ) (x : X) : ℝ :=
  ∫ g, f (g • x) ∂μ

/-- **The Haar average of any observable is a physical observable.** Only right
invariance of the measure is used (a Haar measure of a compact — in particular
finite-dimensional Lie — gauge group is bi-invariant). -/
theorem gaugeAverage_isPhysicalObservable (μ : Measure G) [μ.IsMulRightInvariant]
    (f : X → ℝ) : IsPhysicalObservable G (gaugeAverage (X := X) μ f) := by
  intro h x
  have hmp : MeasurePreserving (fun g : G => g * h) μ μ := measurePreserving_mul_right μ h
  have hme : MeasurableEmbedding (fun g : G => g * h) :=
    (MeasurableEquiv.mulRight h).measurableEmbedding
  have hint := hmp.integral_comp hme (fun g : G => f (g • x))
  simpa [gaugeAverage, mul_smul] using hint

omit [MeasurableMul G] in
/-- The average of a constant observable is that constant: the gauge-invariant
functional is normalized, hence non-trivial. -/
theorem gaugeAverage_const (μ : Measure G) [IsProbabilityMeasure μ] (c : ℝ) :
    gaugeAverage (X := X) μ (fun _ => c) = fun _ => c := by
  funext x
  simp [gaugeAverage]

omit [MeasurableMul G] in
/-- Averaging leaves the already gauge-invariant observables untouched: the Haar
average is a projection onto the physical algebra. -/
theorem gaugeAverage_of_isPhysicalObservable (μ : Measure G) [IsProbabilityMeasure μ]
    {f : X → ℝ} (hf : IsPhysicalObservable G f) :
    gaugeAverage (X := X) μ f = f := by
  funext x
  simp [gaugeAverage, hf _ x]

end Averaging

/-! ### The finite gauge group: averaging with no integrability hypothesis -/

section FiniteAveraging

variable {X : Type*} {G : Type*} [Group G] [Fintype G] [MulAction G X]

/-- The normalized average of an observable over a finite gauge group. -/
noncomputable def finiteGaugeAverage (G : Type*) [Group G] [Fintype G] [MulAction G X]
    (f : X → ℝ) (x : X) : ℝ :=
  (∑ g : G, f (g • x)) / (Fintype.card G)

/-- The average over a finite gauge group is a physical observable. -/
theorem finiteGaugeAverage_isPhysicalObservable (f : X → ℝ) :
    IsPhysicalObservable G (finiteGaugeAverage (X := X) G f) := by
  intro h x
  have hsum : ∑ g : G, f ((g * h) • x) = ∑ g : G, f (g • x) :=
    Equiv.sum_comp (Equiv.mulRight h) (fun g : G => f (g • x))
  simp only [finiteGaugeAverage, mul_smul] at hsum ⊢
  rw [hsum]

/-- The average of a constant is that constant. -/
theorem finiteGaugeAverage_const (c : ℝ) :
    finiteGaugeAverage (X := X) G (fun _ => c) = fun _ => c := by
  funext x
  have hcard : (Fintype.card G : ℝ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero (α := G))
  rw [finiteGaugeAverage]
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  rw [mul_comm, mul_div_assoc, div_self hcard, mul_one]

/-- Averaging fixes the physical observables. -/
theorem finiteGaugeAverage_of_isPhysicalObservable {f : X → ℝ}
    (hf : IsPhysicalObservable G f) :
    finiteGaugeAverage (X := X) G f = f := by
  funext x
  have hcard : (Fintype.card G : ℝ) ≠ 0 := by
    exact_mod_cast (Fintype.card_ne_zero (α := G))
  have hsum : ∑ g : G, f (g • x) = (Fintype.card G : ℝ) * f x := by
    simp [hf _ x, Finset.card_univ, mul_comm]
  rw [finiteGaugeAverage, hsum, mul_comm, mul_div_assoc, div_self hcard, mul_one]

end FiniteAveraging

/-! ### No anomaly for a gauge symmetry (`book.tex` 2389–2395) -/

section NoAnomaly

variable {X : Type*} {G : Type*} [Group G] [MulAction G X]

/-- **A gauge symmetry cannot be anomalous.** An anomaly is the failure of a
symmetry to survive the limit in which a symmetry-breaking parameter is sent to
zero.  But gauge invariance *is* preserved by limits: if every member of a family
of observables is gauge invariant and the family converges pointwise, the limit
observable is gauge invariant as well.  Since only gauge-invariant observables are
considered in the first place, no symmetry breaking can be introduced, and no
anomaly can be observed. -/
theorem isPhysicalObservable_of_tendsto {ι : Type*} {l : Filter ι} [l.NeBot]
    {f : ι → X → ℝ} (hf : ∀ i, IsPhysicalObservable G (f i)) {F : X → ℝ}
    (h : ∀ x, Filter.Tendsto (fun i => f i x) l (nhds (F x))) :
    IsPhysicalObservable G F := by
  intro g x
  have hx : Filter.Tendsto (fun i => f i (g • x)) l (nhds (F x)) := by
    have heq : (fun i => f i (g • x)) = fun i => f i x := funext fun i => hf i g x
    rw [heq]
    exact h x
  exact tendsto_nhds_unique (h (g • x)) hx

end NoAnomaly

/-! ## 3. The pushforward measure implements the exact constraint -/

section Pushforward

variable {X : Type*} [MeasurableSpace X]

/-- **The constrained space is not null.** If `q` projects the (unconstrained)
spectrum measurably into the constrained set `C`, then the pushforward of any
probability measure gives `C` probability one: the exact constraints are
implemented without attributing to the constrained space a null measure. -/
theorem map_measure_constrainedSet (μ : Measure X) [IsProbabilityMeasure μ]
    {C : Set X} (hC : MeasurableSet C) {q : X → X} (hq : Measurable q)
    (hqC : ∀ x, q x ∈ C) : (μ.map q) C = 1 := by
  have hpre : q ⁻¹' C = Set.univ := Set.eq_univ_of_forall hqC
  rw [Measure.map_apply hq hC, hpre, measure_univ]

/-- Expectation values of the observables that are constant along the projection
— in particular of the physical observables, when the projection moves each point
only inside its own gauge equivalence class — are unchanged by the pushforward. -/
theorem integral_map_of_invariant (μ : Measure X) {q : X → X} (hq : Measurable q)
    {f : X → ℝ} (hf : AEStronglyMeasurable f (μ.map q)) (hinv : ∀ x, f (q x) = f x) :
    ∫ x, f x ∂(μ.map q) = ∫ x, f x ∂μ := by
  rw [integral_map hq.aemeasurable hf]
  simp only [hinv]



end Pushforward

end BookProof.ChapterGaugeCasimirAverage
