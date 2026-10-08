import Definitions.Def_ChapterG
import Mathlib


/-!
# Gauge symmetry defined by a *comprehensive but incomplete* gauge fixing

This module formalizes the section *"Gauge transformations, constrained systems
and conditioned probability"* of `book.tex` (lines 2221–2400), and specifically
the argument by which a gauge symmetry can be **defined** at all:

> "Note that it is a subalgebra of the commutative von Neumann algebra that is
> gauge-invariant and not the Hilbert space." (`book.tex` 2260)

> "If we consider instead a commutative von Neumann algebra and its spectrum,
> such that any non-trivial gauge transformation necessarily modifies any point
> of the spectrum while conserving the commutative von Neumann algebra […] then
> such commutative von Neumann algebra is one example of an incomplete
> unconstrained gauge-fixing. […] Such commutative algebra has the crucial
> advantage that the gauge generators are necessarily excluded from the algebra,
> so that it can be used to define a separable Hilbert space compatible with the
> gauge group because the expectation value of any operator of the commutative
> algebra which commutes with the gauge generators is the same at each
> equivalence class." (`book.tex` 2329–2348)

The book's two axes of classification of a gauge fixing are used here with the
book's own vocabulary (`book.tex` 2294–2299, 7406, 7427):

* *comprehensive* — the gauge fixing crosses **at least** once each gauge
  equivalence class (`IsComprehensiveGaugeFixing`);
* *complete* — it crosses **at most** once each class, i.e. there is no remnant
  gauge symmetry (`IsCompleteGaugeFixing'`); the gauge fixing used in the book is
  deliberately **incomplete**;
* *unconstrained* — the gauge generators are excluded from the commutative
  algebra, which here is the condition that every non-trivial gauge
  transformation moves **every** point of the spectrum
  (`MovesEveryPointOfSpectrum`).

The content proved below is:

1. **Spectrum layer.** The full spectrum is a comprehensive gauge fixing
   (`univ_isComprehensiveGaugeFixing`); if every non-trivial gauge transformation
   moves every point (unconstrained), this gauge fixing is necessarily
   *incomplete* (`unconstrained_gauge_fixing_incomplete`), its remnant symmetry
   is a *faithful* representation of the gauge group (`remnant_faithful`), and no
   point of the spectrum is gauge invariant (`no_gauge_invariant_point`).
2. **The physical algebra is nevertheless complete.** Gauge-invariant
   ("physical") observables form a subalgebra (`physicalSubalgebra`), they are
   exactly the functions of the gauge equivalence class
   (`isPhysicalObservable_iff_factors`), two of them that agree on a
   comprehensive gauge fixing are equal (`physical_ext_of_comprehensive`), and
   *every* remnant-invariant observable of a comprehensive gauge fixing is the
   restriction of a physical observable (`exists_physical_extension`). So passing
   to a comprehensive but incomplete gauge fixing loses no physical information.
3. **Hilbert-space layer.** For a unitary representation of the gauge group, the
   physical operators are the commutant (`isPhysicalOperator_iff_mem_centralizer`),
   and their expectation values are the same at every vector of a gauge
   equivalence class (`expectation_physical_gauge_invariant`) — even when no
   vector of the Hilbert space is gauge invariant
   (`no_gauge_invariant_unit_vector_of_free`).
4. **The book's own example** (`book.tex` 2281–2289) — the lattice translations
   `e_k ↦ e_{k+1}` on `ℓ²(ℤ)` — is carried by the companion module
   `BookProof.ChapterGaugeShiftExample`, which is kept independent of this one so
   that the two threads of the development stay separately compilable.

A by-product recorded here: the auxiliary predicate
`ChapterG.IsUnconstrainedGaugeFixing` is unsatisfiable as stated
(`chapterG_isUnconstrainedGaugeFixing_vacuous`), which is why the notion is
re-formalized in this module as a property of the action on the spectrum rather
than of the invariant algebra.  This is a defect of that one predicate only: the
book's *definition* of an unconstrained gauge-fixing is satisfiable, and is
formalized, satisfied and shown to leave the full spectrum unconstrained in
`BookProof.ChapterGaugeUnconstrainedSpectrum`.

Everything is `sorry`-free.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterGaugeIncompleteFixing

/-! ## 1. The spectrum layer: comprehensive, complete, unconstrained -/

section Spectrum

variable {X : Type*}

/-- A gauge fixing `S` (a subset of the spectrum of the commutative algebra) is
**comprehensive** when it crosses *at least* once every gauge equivalence class
(`book.tex` 7406/7427). -/
def IsComprehensiveGaugeFixing (G : Type*) [Group G] [MulAction G X] (S : Set X) :
    Prop :=
  ∀ x : X, ∃ s ∈ S, ∃ g : G, g • s = x

/-- A gauge fixing `S` is **complete** when it crosses *at most* once each gauge
equivalence class, i.e. when there is no remnant gauge symmetry inside `S`
(`book.tex` 2294). -/
def IsCompleteGaugeFixing' (G : Type*) [Group G] [MulAction G X] (S : Set X) :
    Prop :=
  ∀ s ∈ S, ∀ t ∈ S, ∀ g : G, g • s = t → s = t

/-- The book's **unconstrained** condition, as a property of the action on the
spectrum: *"any non-trivial gauge transformation necessarily modifies any point
of the spectrum"* (`book.tex` 2336). It is exactly what forces the gauge
generators out of the commutative algebra. -/
def MovesEveryPointOfSpectrum (G : Type*) [Group G] (X : Type*) [MulAction G X] :
    Prop :=
  ∀ g : G, g ≠ 1 → ∀ x : X, g • x ≠ x

/-- A **physical observable**: an element of the commutative algebra that is
gauge invariant, i.e. constant on the gauge equivalence classes. -/
def IsPhysicalObservable (G : Type*) [Group G] [MulAction G X] (f : X → ℝ) : Prop :=
  ∀ (g : G) (x : X), f (g • x) = f x

variable (G : Type*) [Group G] [MulAction G X]







/-- **No point of the specge transformations, constrained systems
and conditioned probability"* of `book.tex` (lines 2221–2400), and specifically
the argument by which a gauge symmetry can be **defined** at all:

> "Note that it is a subalgebra of the commutative von Neumann algebra that is
> gauge-invariant and not the Hilbert space." (`book.tex` 2260)

> "If we consider instead a commutative von Neumann algebra and its spectrum,
> such that any non-trivial gauge transformation necessarily modifies any point
> of the spectrum while conserving the commutative von Neumann algebra […] then
> such commutative von Neumann algebra is one example of an incomplete
> unconstrained gauge-fixing. […] Such commutative algebra has the crucial
> advantage that the gauge generators are necessarily excluded from the algebra,
> so that it can be used to define a separable Hilbert space compatible with the
> gauge group because the expectation value of any operator of the commutative
> algebra which commutes with the gauge generators is the same at each
> equivalence class." (`book.tex` 2329–2348)

The book's two axes of classification of a gauge fixing are used here with the
book's own vocabulary (`book.tex` 2294–2299, 7406, 7427):

* *comprehensive* — the gauge fixing crosses **at least** once each gauge
  equivalence class (`IsComprehensiveGaugeFixing`);
* *complete* — it crosses **at most** once each class, i.e. there is no remnant
  gauge symmetry (`IsCompleteGaugeFixing'`); the gauge fixing used in the book is
  deliberately **incomplete**;
* *unconstrained* — the gauge generators are excluded from the commutative
  algebra, which here is the condition that every non-trivial gauge
  transformation moves **every** point of the spectrum
  (`MovesEveryPointOfSpectrum`).

The content proved below is:

1. **Spectrum layer.** The full spectrum is a comprehensive gauge fixing
   (`univ_isComprehensiveGaugeFixing`); if every non-trivial gauge transformation
   moves every point (unconstrained), this gauge fixing is necessarily
   *incomplete* (`unconstrained_gauge_fixing_incomplete`), its remnant symmetry
   is a *faithful* representation of the gauge group (`remnant_faithful`), and no
   point of the spectrum is gauge invariant (`no_gauge_invariant_point`).
2. **The physical algebra is nevertheless complete.** Gauge-invariant
   ("physical") observables form a subalgebra (`physicalSubalgebra`), they are
   exactly the functions of the gauge equivalence class
   (`isPhysicalObservable_iff_factors`), two of them that agree on a
   comprehensive gauge fixing are equal (`physical_ext_of_comprehensive`), and
   *every* remnant-invariant observable of a comprehensive gauge fixing is the
   restriction of a physical observable (`exists_physical_extension`). So passing
   to a comprehensive but incomplete gauge fixing loses no physical information.
3. **Hilbert-space layer.** For a unitary representation of the gauge group, the
   physical operators are the commutant (`isPhysicalOperator_iff_mem_centralizer`),
   and their expectation values are the same at every vector of a gauge
   equivalence class (`expectation_physical_gauge_invariant`) — even when no
   vector of the Hilbert space is gauge invariant
   (`no_gauge_invariant_unit_vector_of_free`).
4. **The book's own example** (`book.tex` 2281–2289) — the lattice translations
   `e_k ↦ e_{k+1}` on `ℓ²(ℤ)` — is carried by the companion module
   `BookProof.ChapterGaugeShiftExample`, which is kept independent of this one so
   that the two threads of the development stay separately compilable.

A by-product recorded here: the auxiliary predicate
`ChapterG.IsUnconstrainedGaugeFixing` is unsatisfiable as stated
(`chapterG_isUnconstrainedGaugeFixing_vacuous`), which is why the notion is
re-formalized in this module as a property of the action on the spectrum rather
than of the invariant algebra.  This is a defect of that one predicate only: the
book's *definition* of an unconstrained gauge-fixing is satisfiable, and is
formalized, satisfied and shown to leave the full spectrum unconstrained in
`BookProof.ChapterGaugeUnconstrainedSpectrum`.

Everything is `sorry`-free.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterGaugeIncompleteFixing

/-! ## 1. The spectrum layer: comprehensive, complete, unconstrained -/

section Spectrum

variable {X : Type*}

/-- A gauge fixing `S` (a subset of the spectrum of the commutative algebra) is
**comprehensive** when it crosses *at least* once every gauge equivalence class
(`book.tex` 7406/7427). -/
def IsComprehensiveGaugeFixing (G : Type*) [Group G] [MulAction G X] (S : Set X) :
    Prop :=
  ∀ x : X, ∃ s ∈ S, ∃ g : G, g • s = x

/-- A gauge fixing `S` is **complete** when it crosses *at most* once each gauge
equivalence class, i.e. when there is no remnant gauge symmetry inside `S`
(`book.tex` 2294). -/
def IsCompleteGaugeFixing' (G : Type*) [Group G] [MulAction G X] (S : Set X) :
    Prop :=
  ∀ s ∈ S, ∀ t ∈ S, ∀ g : G, g • s = t → s = t

/-- The book's **unconstrained** condition, as a property of the action on the
spectrum: *"any non-trivial gauge transformation necessarily modifies any point
of the spectrum"* (`book.tex` 2336). It is exactly what forces the gauge
generators out of the commutative algebra. -/
def MovesEveryPointOfSpectrum (G : Type*) [Group G] (X : Type*) [MulAction G X] :
    Prop :=
  ∀ g : G, g ≠ 1 → ∀ x : X, g • x ≠ x

/-- A **physical observable**: an element of the commutative algebra that is
gauge invariant, i.e. constant on the gauge equivalence classes. -/
def IsPhysicalObservable (G : Type*) [Group G] [MulAction G X] (f : X → ℝ) : Prop :=
  ∀ (g : G) (x : X), f (g • x) = f x

variable (G : Type*) [Group G] [MulAction G X]

/-- The whole spectrum is a comprehensive gauge fixing: it meets every gauge
equivalence class. -/
theorem univ_isComprehensiveGaugeFixing :
    IsComprehensiveGaugeFixing G (Set.univ : Set X) :=
  fun x => ⟨x, Set.mem_univ x, 1, one_smul G x⟩

/-- **Incompleteness.** If the gauge fixing is unconstrained — every non-trivial
gauge transformation moves every point — and the gauge group is non-trivial, then
the gauge fixing is *incomplete*: some equivalence class is crossed twice. -/
theorem unconstrained_gauge_fixing_incomplete [Nontrivial G] [Nonempty X]
    (h : MovesEveryPointOfSpectrum G X) :
    ¬ IsCompleteGaugeFixing' G (Set.univ : Set X) := by
  intro hcomp
  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  obtain ⟨x⟩ := ‹Nonempty X›
  exact h g hg x (hcomp x (Set.mem_univ x) (g • x) (Set.mem_univ _) g rfl).symm

/-- **The remnant gauge symmetry is faithful** (`book.tex` 2339–2341): under the
unconstrained condition, a gauge element acting trivially on the spectrum is the
identity. -/
theorem remnant_faithful [Nonempty X] (h : MovesEveryPointOfSpectrum G X)
    {g : G} (hg : ∀ x : X, g • x = x) : g = 1 := by
  by_contra hne
  obtain ⟨x⟩ := ‹Nonempty X›
  exact h g hne x (hg x)

/-- **No point of the spectrum is gauge invariant**: the gauge symmetry cannot be
carried by the points (states), only by the algebra. -/
theorem no_gauge_invariant_point [Nontrivial G] (h : MovesEveryPointOfSpectrum G X)
    (x : X) : ∃ g : G, g • x ≠ x := by
  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  exact ⟨g, h g hg x⟩

/-! ### The physical (gauge-invariant) algebra -/

/-- The gauge-invariant observables form a subalgebra of the commutative algebra
of all observables — the *physical* algebra. -/
noncomputable def physicalSubalgebra : Subalgebra ℝ (X → ℝ) where
  carrier := {f | IsPhysicalObservable G f}
  mul_mem' hf hg g x := by simp only [Pi.mul_apply, hf g x, hg g x]
  add_mem' hf hg g x := by simp only [Pi.add_apply, hf g x, hg g x]
  algebraMap_mem' _ _ _ := rfl

@[simp] theorem mem_physicalSubalgebra {f : X → ℝ} :
    f ∈ physicalSubalgebra G ↔ IsPhysicalObservable G f := Iff.rfl









end Spectrum

/-! ## 2. The Hilbert-space layer: physical operators versus state vectors -/

section Hilbert

variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- A family `U` of gauge unitaries on the Hilbert space. -/
def IsGaugeUnitaryFamily (U : G → (H →L[ℂ] H)) : Prop :=
  ∀ g : G, U g ∈ unitary (H →L[ℂ] H)

/-- A **physical operator** is one that commutes with every gauge unitary — the
book's *"operator of the commutative algebra which commutes with the gauge
generators"* (`book.tex` 2344). -/
def IsPhysicalOperator (U : G → (H →L[ℂ] H)) (A : H →L[ℂ] H) : Prop :=
  ∀ g : G, A * U g = U g * A







end Hilbert

/-! ## 3. A correction to an earlier predicate

`ChapterG.IsUnconstrainedGaugeFixing π` asks for a *gauge-invariant* function `f`
and a gauge transformation `g` with `f ∘ g ≠ f`, which contradicts invariance of
`f`: that predicate is unsatisfiable, so every statement conditioned on it is
vacuous. This says nothing against the book's definition, which is satisfiable:
the unconstrained condition be **defined** at all:

> "Note that it is a subalgebra of the commutative von Neumann algebra that is
> gauge-invariant and not the Hilbert space." (`book.tex` 2260)

> "If we consider instead a commutative von Neumann algebra and its spectrum,
> such that any non-trivial gauge transformation necessarily modifies any point
> of the spectrum while conserving the commutative von Neumann algebra […] then
> such commutative von Neumann algebra is one example of an incomplete
> unconstrained gauge-fixing. […] Such commutative algebra has the crucial
> advantage that the gauge generators are necessarily excluded from the algebra,
> so that it can be used to define a separable Hilbert space compatible with the
> gauge group because the expectation value of any operator of the commutative
> algebra which commutes with the gauge generators is the same at each
> equivalence class." (`book.tex` 2329–2348)

The book's two axes of classification of a gauge fixing are used here with the
book's own vocabulary (`book.tex` 2294–2299, 7406, 7427):

* *comprehensive* — the gauge fixing crosses **at least** once each gauge
  equivalence class (`IsComprehensiveGaugeFixing`);
* *complete* — it crosses **at most** once each class, i.e. there is no remnant
  gauge symmetry (`IsCompleteGaugeFixing'`); the gauge fixing used in the book is
  deliberately **incomplete**;
* *unconstrained* — the gauge generators are excluded from the commutative
  algebra, which here is the condition that every non-trivial gauge
  transformation moves **every** point of the spectrum
  (`MovesEveryPointOfSpectrum`).

The content proved below is:

1. **Spectrum layer.** The full spectrum is a comprehensive gauge fixing
   (`univ_isComprehensiveGaugeFixing`); if every non-trivial gauge transformation
   moves every point (unconstrained), this gauge fixing is necessarily
   *incomplete* (`unconstrained_gauge_fixing_incomplete`), its remnant symmetry
   is a *faithful* representation of the gauge group (`remnant_faithful`), and no
   point of the spectrum is gauge invariant (`no_gauge_invariant_point`).
2. **The physical algebra is nevertheless complete.** Gauge-invariant
   ("physical") observables form a subalgebra (`physicalSubalgebra`), they are
   exactly the functions of the gauge equivalence class
   (`isPhysicalObservable_iff_factors`), two of them that agree on a
   comprehensive gauge fixing are equal (`physical_ext_of_comprehensive`), and
   *every* remnant-invariant observable of a comprehensive gauge fixing is the
   restriction of a physical observable (`exists_physical_extension`). So passing
   to a comprehensive but incomplete gauge fixing loses no physical information.
3. **Hilbert-space layer.** For a unitary representation of the gauge group, the
   physical operators are the commutant (`isPhysicalOperator_iff_mem_centralizer`),
   and their expectation values are the same at every vector of a gauge
   equivalence class (`expectation_physical_gauge_invariant`) — even when no
   vector of the Hilbert space is gauge invariant
   (`no_gauge_invariant_unit_vector_of_free`).
4. **The book's own example** (`book.tex` 2281–2289) — the lattice translations
   `e_k ↦ e_{k+1}` on `ℓ²(ℤ)` — is carried by the companion module
   `BookProof.ChapterGaugeShiftExample`, which is kept independent of this one so
   that the two threads of the development stay separately compilable.

A by-product recorded here: the auxiliary predicate
`ChapterG.IsUnconstrainedGaugeFixing` is unsatisfiable as stated
(`chapterG_isUnconstrainedGaugeFixing_vacuous`), which is why the notion is
re-formalized in this module as a property of the action on the spectrum rather
than of the invariant algebra.  This is a defect of that one predicate only: the
book's *definition* of an unconstrained gauge-fixing is satisfiable, and is
formalized, satisfied and shown to leave the full spectrum unconstrained in
`BookProof.ChapterGaugeUnconstrainedSpectrum`.

Everything is `sorry`-free.
-/

open scoped InnerProductSpace

namespace BookProof.ChapterGaugeIncompleteFixing

/-! ## 1. The spectrum layer: comprehensive, complete, unconstrained -/

section Spectrum

variable {X : Type*}

/-- A gauge fixing `S` (a subset of the spectrum of the commutative algebra) is
**comprehensive** when it crosses *at least* once every gauge equivalence class
(`book.tex` 7406/7427). -/
def IsComprehensiveGaugeFixing (G : Type*) [Group G] [MulAction G X] (S : Set X) :
    Prop :=
  ∀ x : X, ∃ s ∈ S, ∃ g : G, g • s = x

/-- A gauge fixing `S` is **complete** when it crosses *at most* once each gauge
equivalence class, i.e. when there is no remnant gauge symmetry inside `S`
(`book.tex` 2294). -/
def IsCompleteGaugeFixing' (G : Type*) [Group G] [MulAction G X] (S : Set X) :
    Prop :=
  ∀ s ∈ S, ∀ t ∈ S, ∀ g : G, g • s = t → s = t

/-- The book's **unconstrained** condition, as a property of the action on the
spectrum: *"any non-trivial gauge transformation necessarily modifies any point
of the spectrum"* (`book.tex` 2336). It is exactly what forces the gauge
generators out of the commutative algebra. -/
def MovesEveryPointOfSpectrum (G : Type*) [Group G] (X : Type*) [MulAction G X] :
    Prop :=
  ∀ g : G, g ≠ 1 → ∀ x : X, g • x ≠ x

/-- A **physical observable**: an element of the commutative algebra that is
gauge invariant, i.e. constant on the gauge equivalence classes. -/
def IsPhysicalObservable (G : Type*) [Group G] [MulAction G X] (f : X → ℝ) : Prop :=
  ∀ (g : G) (x : X), f (g • x) = f x

variable (G : Type*) [Group G] [MulAction G X]

/-- The whole spectrum is a comprehensive gauge fixing: it meets every gauge
equivalence class. -/
theorem univ_isComprehensiveGaugeFixing :
    IsComprehensiveGaugeFixing G (Set.univ : Set X) :=
  fun x => ⟨x, Set.mem_univ x, 1, one_smul G x⟩

/-- **Incompleteness.** If the gauge fixing is unconstrained — every non-trivial
gauge transformation moves every point — and the gauge group is non-trivial, then
the gauge fixing is *incomplete*: some equivalence class is crossed twice. -/
theorem unconstrained_gauge_fixing_incomplete [Nontrivial G] [Nonempty X]
    (h : MovesEveryPointOfSpectrum G X) :
    ¬ IsCompleteGaugeFixing' G (Set.univ : Set X) := by
  intro hcomp
  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  obtain ⟨x⟩ := ‹Nonempty X›
  exact h g hg x (hcomp x (Set.mem_univ x) (g • x) (Set.mem_univ _) g rfl).symm

/-- **The remnant gauge symmetry is faithful** (`book.tex` 2339–2341): under the
unconstrained condition, a gauge element acting trivially on the spectrum is the
identity. -/
theorem remnant_faithful [Nonempty X] (h : MovesEveryPointOfSpectrum G X)
    {g : G} (hg : ∀ x : X, g • x = x) : g = 1 := by
  by_contra hne
  obtain ⟨x⟩ := ‹Nonempty X›
  exact h g hne x (hg x)

/-- **No point of the spectrum is gauge invariant**: the gauge symmetry cannot be
carried by the points (states), only by the algebra. -/
theorem no_gauge_invariant_point [Nontrivial G] (h : MovesEveryPointOfSpectrum G X)
    (x : X) : ∃ g : G, g • x ≠ x := by
  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  exact ⟨g, h g hg x⟩

/-! ### The physical (gauge-invariant) algebra -/

/-- The gauge-invariant observables form a subalgebra of the commutative algebra
of all observables — the *physical* algebra. -/
noncomputable def physicalSubalgebra : Subalgebra ℝ (X → ℝ) where
  carrier := {f | IsPhysicalObservable G f}
  mul_mem' hf hg g x := by simp only [Pi.mul_apply, hf g x, hg g x]
  add_mem' hf hg g x := by simp only [Pi.add_apply, hf g x, hg g x]
  algebraMap_mem' _ _ _ := rfl

@[simp] theorem mem_physicalSubalgebra {f : X → ℝ} :
    f ∈ physicalSubalgebra G ↔ IsPhysicalObservable G f := Iff.rfl

/-- The physical algebra always contains the constants, so it is non-trivial even
when no state is gauge invariant (the point of `book.tex` 2286–2289). -/
theorem one_mem_physicalSubalgebra : (1 : X → ℝ) ∈ physicalSubalgebra G :=
  fun _ _ => rfl

/-- A physical observable is exactly a function of the gauge equivalence class:
it factors through the quotient by the orbit relation. -/
theorem isPhysicalObservable_iff_factors (f : X → ℝ) :
    IsPhysicalObservable G f ↔
      ∃ F : Quotient (MulAction.orbitRel G X) → ℝ,
        ∀ x : X, f x = F (Quotient.mk (MulAction.orbitRel G X) x) := by
  constructor
  · intro hf
    refine ⟨Quotient.lift f ?_, fun x => rfl⟩
    intro a b hab
    obtain ⟨g, hg⟩ := hab
    simp only at hg
    rw [← hg, hf g b]
  · rintro ⟨F, hF⟩ g x
    rw [hF (g • x), hF x]
    congr 1
    exact Quotient.sound (MulAction.mem_orbit x g)

/-- **Comprehensiveness is exactly what makes the gauge fixing lossless (1/2).**
Two physical observables that agree on a comprehensive gauge fixing are equal:
the restriction to the gauge-fixing surface determines the observable. -/
theorem physical_ext_of_comprehensive {S : Set X}
    (hS : IsComprehensiveGaugeFixing G S) {f f' : X → ℝ}
    (hf : IsPhysicalObservable G f) (hf' : IsPhysicalObservable G f')
    (hagree : ∀ s ∈ S, f s = f' s) : f = f' := by
  funext x
  obtain ⟨s, hsS, g, rfl⟩ := hS x
  rw [hf g s, hf' g s, hagree s hsS]

/-- **Comprehensiveness is exactly what makes the gauge fixing lossless (2/2).**
Every observable defined on a comprehensive gauge fixing and invariant under the
*remnant* gauge symmetry (the transformations that stay inside the surface) is
the restriction of a physical observable of the whole spectrum. Completeness of
the gauge fixing is never used. -/
theorem exists_physical_extension {S : Set X}
    (hS : IsComprehensiveGaugeFixing G S) (h : X → ℝ)
    (hrem : ∀ s ∈ S, ∀ t ∈ S, ∀ g : G, g • s = t → h s = h t) :
    ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s := by
  classical
  -- choose, in every gauge equivalence class, a representative inside `S`
  have hrep : ∀ c : Quotient (MulAction.orbitRel G X),
      ∃ s : X, s ∈ S ∧ Quotient.mk (MulAction.orbitRel G X) s = c := by
    intro c
    induction c using Quotient.inductionOn with
    | h x =>
      obtain ⟨s, hsS, g, hg⟩ := hS x
      refine ⟨s, hsS, ?_⟩
      rw [← hg]
      exact (Quotient.sound (MulAction.mem_orbit s g)).symm
  set r : Quotient (MulAction.orbitRel G X) → X := fun c => (hrep c).choose
  have hrS : ∀ c, r c ∈ S := fun c => (hrep c).choose_spec.1
  have hrmk : ∀ c, Quotient.mk (MulAction.orbitRel G X) (r c) = c :=
    fun c => (hrep c).choose_spec.2
  refine ⟨fun x => h (r (Quotient.mk (MulAction.orbitRel G X) x)), ?_, ?_⟩
  · intro g x
    have hq : Quotient.mk (MulAction.orbitRel G X) (g • x)
        = Quotient.mk (MulAction.orbitRel G X) x :=
      Quotient.sound (MulAction.mem_orbit x g)
    simp only [hq]
  · intro s hsS
    have hmk : Quotient.mk (MulAction.orbitRel G X)
        (r (Quotient.mk (MulAction.orbitRel G X) s)) =
        Quotient.mk (MulAction.orbitRel G X) s := hrmk _
    obtain ⟨g, hg⟩ := Quotient.exact hmk
    simp only at hg
    exact (hrem s hsS _ (hrS _) g hg).symm

end Spectrum

/-! ## 2. The Hilbert-space layer: physical operators versus state vectors -/

section Hilbert

variable {G : Type*} [Group G]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

/-- A family `U` of gauge unitaries on the Hilbert space. -/
def IsGaugeUnitaryFamily (U : G → (H →L[ℂ] H)) : Prop :=
  ∀ g : G, U g ∈ unitary (H →L[ℂ] H)

/-- A **physical operator** is one that commutes with every gauge unitary — the
book's *"operator of the commutative algebra which commutes with the gauge
generators"* (`book.tex` 2344). -/
def IsPhysicalOperator (U : G → (H →L[ℂ] H)) (A : H →L[ℂ] H) : Prop :=
  ∀ g : G, A * U g = U g * A

omit [Group G] [CompleteSpace H] in
/-- The physical operators are exactly the commutant (centralizer) of the gauge
unitaries; in particular they form a subalgebra. -/
theorem isPhysicalOperator_iff_mem_centralizer (U : G → (H →L[ℂ] H))
    (A : H →L[ℂ] H) :
    IsPhysicalOperator U A ↔ A ∈ Subalgebra.centralizer ℂ (Set.range U) := by
  constructor
  · rintro hA _ ⟨g, rfl⟩
    exact (hA g).symm
  · intro hA g
    exact (hA (U g) ⟨g, rfl⟩).symm

omit [Group G] in
/-- **The physical expectation values are gauge invariant** (`book.tex`
2344–2347): the expectation value of a physical operator is the same at every
vector of a gauge equivalence class, so it is a function of the class alone —
even though the vectors of the class are all different. -/
theorem expectation_physical_gauge_invariant {U : G → (H →L[ℂ] H)}
    (hU : IsGaugeUnitaryFamily U) {A : H →L[ℂ] H} (hA : IsPhysicalOperator U A)
    (g : G) (Ψ : H) :
    ⟪U g Ψ, A (U g Ψ)⟫_ℂ = ⟪Ψ, A Ψ⟫_ℂ :=
  ChapterG.expectation_gauge_invariant (U g) (hU g) A (hA g) Ψ

omit [CompleteSpace H] in
/-- **The vectors of the Hilbert space need not be gauge invariant.** If the
gauge action is free on non-zero vectors (the Hilbert-space form of the book's
unconstrained condition) and the gauge group is non-trivial, then no unit vector
is gauge invariant. -/
theorem no_gauge_invariant_unit_vector_of_free [Nontrivial G]
    {U : G → (H →L[ℂ] H)}
    (hfree : ∀ g : G, g ≠ 1 → ∀ Ψ : H, Ψ ≠ 0 → U g Ψ ≠ Ψ) :
    ¬ ∃ Ψ : H, ‖Ψ‖ = 1 ∧ ∀ g : G, U g Ψ = Ψ := by
  rintro ⟨Ψ, hnorm, hinv⟩
  obtain ⟨g, hg⟩ := exists_ne (1 : G)
  have hΨ : Ψ ≠ 0 := by
    intro h
    rw [h, norm_zero] at hnorm
    exact one_ne_zero hnorm.symm
  exact hfree g hg Ψ hΨ (hinv g)

end Hilbert

/-! ## 3. A correction to an earlier predicate

`ChapterG.IsUnconstrainedGaugeFixing π` asks for a *gauge-invariant* function `f`
and a gauge transformation `g` with `f ∘ g ≠ f`, which contradicts invariance of
`f`: that predicate is unsatisfiable, so every statement conditioned on it is
vacuous. This says nothing against the book's definition, which is satisfiable:
the unconstrained condition of the book is the exclusion of the gauge generators
from the commutative algebra — so that they impose no constraint on the full
spectrum labelled by the basis vectors — formalized in
`BookProof.ChapterGaugeUnconstrainedSpectrum`, and equivalently rendered here as
the condition `MovesEveryPointOfSpectrum` on the action on the spectrum. -/

/-- `ChapterG.IsUnconstrainedGaugeFixing` is never satisfied. -/
theorem chapterG_isUnconstrainedGaugeFixing_vacuous {X Y : Type*} (π : X → Y) :
    ¬ ChapterG.IsUnconstrainedGaugeFixing π := by
  rintro ⟨g, hg, f, hf⟩
  exact hf (funext fun x => f.property g hg x)

end BookProof.ChapterGaugeIncompleteFixing
