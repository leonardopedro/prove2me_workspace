import Definitions.Def_ChapterGaugeIncompleteFixing
import Mathlib


/-!
# Comprehensive gauge fixings: existence, uniqueness of the extension, and the
Gribov obstruction

This module continues the formalization of the section *"Gauge transformations,
constrained systems and conditioned probability"* of `book.tex` (lines 2221–2400).
The companion module `BookProof.ChapterGaugeIncompleteFixing` sets up the book's
vocabulary — a gauge fixing is a subset `S` of the spectrum of the commutative von
Neumann algebra, it is *comprehensive* when it crosses at least once each gauge
equivalence class, *complete* when it crosses at most once each class, and
*unconstrained* when every non-trivial gauge transformation moves every point of
the spectrum — and proves that a comprehensive gauge fixing loses no physical
information.  What is added here is the *existence* theory and the obstruction the
book attributes to the Gribov ambiguity:

> "The Dirac brackets require the gauge-fixing to be both unconstrained and
> complete (as if the gauge symmetry could be eliminated), which is not possible
> in general due to the Gribov ambiguity." (`book.tex` 2301–2304)

## Results

* `orbitRepresentatives_isComprehensiveGaugeFixing`,
  `orbitRepresentatives_isCompleteGaugeFixing'`,
  `exists_comprehensive_complete_gaugeFixing` — a gauge fixing which is
  simultaneously comprehensive and complete always exists *as a set*: the set of
  representatives of the gauge equivalence classes.  So the obstruction below is
  not a set-theoretic one.
* `existsUnique_mem_of_complete_comprehensive` — on such a gauge fixing each point
  of the spectrum has exactly one gauge representative, and
  `exists_physical_extension_of_complete`,
  `existsUnique_physical_extension_of_complete` — *every* function on it is the
  restriction of exactly one gauge-invariant (physical) observable: a complete
  comprehensive gauge fixing is a faithful parametrization of the physical
  algebra.
* `not_isPhysicalObservable_indicator` — nevertheless the gauge-fixing condition
  itself is never a physical observable when the gauge group acts freely: the
  gauge fixing is extra data, not an observable.
* `not_isClopen_of_complete_comprehensive` — **the obstruction.**  If the spectrum
  is connected and the gauge group acts freely and non-trivially, a complete
  comprehensive gauge fixing is never clopen, i.e. it can never be cut out by a
  locally constant (continuous) gauge condition.  Completeness can be achieved
  only by a discontinuous choice.
* The book's simplest concrete instance, `ℤ` acting on the line by translations
  (`shiftAction`): the unit cell `[0,1)` is a complete comprehensive gauge fixing
  (`unitCell_isComprehensiveGaugeFixing`, `unitCell_isCompleteGaugeFixing'`),
  the action is unconstrained in the book's sense
  (`shift_movesEveryPointOfSpectrum`), and no complete comprehensive gauge fixing
  of this action is clopen (`shift_no_clopen_complete_gaugeFixing`) — an explicit
  Gribov-type ambiguity.
* `physical_ext_iff_comprehensive`, `physical_extension_iff_complete` — the two
  axes of the book's classification are **exactly** the two halves of the
  statement that restriction to the gauge-fixing surface is a bijection from the
  physical algebra onto the functions of the surface: comprehensiveness is
  injectivity (no physical information is lost), completeness is surjectivity (no
  remnant symmetry constrains the surface).
* `spuriousSection_isComprehensiveGaugeFixing`,
  `spuriousSection_isCompleteGaugeFixing'` — the manuscript's device of adjoining
  a *spurious* field with a constraint (`book.tex` 7406) does produce a gauge
  fixing that is at once complete and comprehensive, for an arbitrary gauge
  group: the spurious factor is a copy of the gauge group, fixed to the
  identity.
* `shift_gaugeFixing_classification` — all four combinations of the two axes
  occur, with explicit witnesses for the translation gauge symmetry of the line;
  the book uses a *complete non-comprehensive* fixing (the magnetic components in
  the Weyl gauge, `book.tex` 7427) as well as *complete and comprehensive* ones
  (`book.tex` 7406) and the incomplete unconstrained one of `book.tex` 2336.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterGaugeComprehensiveFixing

open BookProof.ChapterGaugeIncompleteFixing

/-! ## 1. Existence of a complete comprehensive gauge fixing -/

section Existence

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]

/-- A set of representatives of the gauge equivalence classes: one point of the
spectrum chosen in each class. -/
noncomputable def orbitRepresentatives : Set X :=
  Set.range fun c : Quotient (MulAction.orbitRel G X) => c.out







end Existence

/-! ## 2. A complete comprehensive gauge fixing parametrizes the physical algebra -/

section Complete

variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}









end Complete

/-! ## 3. The Gribov obstruction: completeness is incompatible with continuity -/

section Gribov

variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]



end Gribov

/-! ## 4. The two axes are injectivity and surjectivity of the restriction -/

section Classification

variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}









end Classification

/-! ## 5. The spurious field of `book.tex` 7406 -/

section Spurious

variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

/-- The gauge fixing obtained by adjoining a *spurious* degree of freedom that
takes values in the gauge group itself and setting it to the identity — the
manuscript's "new field `Φ` and new constraint `Π = 0`" which "allows a complete
and comprehensive gauge-fixing" (`book.tex` 7406).  The gauge group acts
diagonally on `X × G`, by the original action on `X` and by left translation on
the spurious factor. -/
def spuriousSection : Set (X × G) := {p | p.2 = 1}





end Spurious

/-! ## 6. The book's concrete example: translations of the line -/

section Shift

/-- The gauge group `ℤ` (written multiplicatively) acting on the spectrum `ℝ` by
translations.  This is the continuous analogue of the book's lattice example
`e_k ↦ e_{k+1}` (`book.tex` 2281–2289). -/
scoped instance shiftAction : MulAction (Multiplicative ℤ) ℝ where
  smul n x := ((Multiplicative.toAdd n : ℤ) : ℝ) + x
  one_smul x := by
    change ((0 : ℤ) : ℝ) + x = x
    simp
  mul_smul m n x := by
    change ((Multiplicative.toAdd (m * n) : ℤ) : ℝ) + x
        = ((Multiplicative.toAdd m : ℤ) : ℝ) + (((Multiplicative.toAdd n : ℤ) : ℝ) + x)
    rw [show Multiplicative.toAdd (m * n)
        = Multiplicative.toAdd m + Multiplicative.toAdd n from rfl]
    push_cast
    ring



/-- The unit cell `[0, 1)`: the standard gauge fixing of the translation gauge
symmetry of the line. -/
def unitCell : Set ℝ := Set.Ico 0 1













n algebra, it is *comprehensive* when it crosses at least once each gauge
equivalence class, *complete* when it crosses at most once each class, and
*unconstrained* when every non-trivial gauge transformation moves every point of
the spectrum — and proves that a comprehensive gauge fixing loses no physical
information.  What is added here is the *existence* theory and the obstruction the
book attributes to the Gribov ambiguity:

> "The Dirac brackets require the gauge-fixing to be both unconstrained and
> complete (as if the gauge symmetry could be eliminated), which is not possible
> in general due to the Gribov ambiguity." (`book.tex` 2301–2304)

## Results

* `orbitRepresentatives_isComprehensiveGaugeFixing`,
  `orbitRepresentatives_isCompleteGaugeFixing'`,
  `exists_comprehensive_complete_gaugeFixing` — a gauge fixing which is
  simultaneously comprehensive and complete always exists *as a set*: the set of
  representatives of the gauge equivalence classes.  So the obstruction below is
  not a set-theoretic one.
* `existsUnique_mem_of_complete_comprehensive` — on such a gauge fixing each point
  of the spectrum has exactly one gauge representative, and
  `exists_physical_extension_of_complete`,
  `existsUnique_physical_extension_of_complete` — *every* function on it is the
  restriction of exactly one gauge-invariant (physical) observable: a complete
  comprehensive gauge fixing is a faithful parametrization of the physical
  algebra.
* `not_isPhysicalObservable_indicator` — nevertheless the gauge-fixing condition
  itself is never a physical observable when the gauge group acts freely: the
  gauge fixing is extra data, not an observable.
* `not_isClopen_of_complete_comprehensive` — **the obstruction.**  If the spectrum
  is connected and the gauge group acts freely and non-trivially, a complete
  comprehensive gauge fixing is never clopen, i.e. it can never be cut out by a
  locally constant (continuous) gauge condition.  Completeness can be achieved
  only by a discontinuous choice.
* The book's simplest concrete instance, `ℤ` acting on the line by translations
  (`shiftAction`): the unit cell `[0,1)` is a complete comprehensive gauge fixing
  (`unitCell_isComprehensiveGaugeFixing`, `unitCell_isCompleteGaugeFixing'`),
  the action is unconstrained in the book's sense
  (`shift_movesEveryPointOfSpectrum`), and no complete comprehensive gauge fixing
  of this action is clopen (`shift_no_clopen_complete_gaugeFixing`) — an explicit
  Gribov-type ambiguity.
* `physical_ext_iff_comprehensive`, `physical_extension_iff_complete` — the two
  axes of the book's classification are **exactly** the two halves of the
  statement that restriction to the gauge-fixing surface is a bijection from the
  physical algebra onto the functions of the surface: comprehensiveness is
  injectivity (no physical information is lost), completeness is surjectivity (no
  remnant symmetry constrains the surface).
* `spuriousSection_isComprehensiveGaugeFixing`,
  `spuriousSection_isCompleteGaugeFixing'` — the manuscript's device of adjoining
  a *spurious* field with a constraint (`book.tex` 7406) does produce a gauge
  fixing that is at once complete and comprehensive, for an arbitrary gauge
  group: the spurious factor is a copy of the gauge group, fixed to the
  identity.
* `shift_gaugeFixing_classification` — all four combinations of the two axes
  occur, with explicit witnesses for the translation gauge symmetry of the line;
  the book uses a *complete non-comprehensive* fixing (the magnetic components in
  the Weyl gauge, `book.tex` 7427) as well as *complete and comprehensive* ones
  (`book.tex` 7406) and the incomplete unconstrained one of `book.tex` 2336.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ChapterGaugeComprehensiveFixing

open BookProof.ChapterGaugeIncompleteFixing

/-! ## 1. Existence of a complete comprehensive gauge fixing -/

section Existence

variable {X : Type*} (G : Type*) [Group G] [MulAction G X]

/-- A set of representatives of the gauge equivalence classes: one point of the
spectrum chosen in each class. -/
noncomputable def orbitRepresentatives : Set X :=
  Set.range fun c : Quotient (MulAction.orbitRel G X) => c.out

theorem orbitRepresentatives_isComprehensiveGaugeFixing :
    IsComprehensiveGaugeFixing G (orbitRepresentatives (X := X) G) := by
  intro x
  refine ⟨(Quotient.mk (MulAction.orbitRel G X) x).out, ⟨_, rfl⟩, ?_⟩
  have h : Quotient.mk (MulAction.orbitRel G X)
      (Quotient.mk (MulAction.orbitRel G X) x).out
      = Quotient.mk (MulAction.orbitRel G X) x := Quotient.out_eq _
  obtain ⟨g, hg⟩ := Quotient.exact h
  exact ⟨g⁻¹, by rw [← hg, inv_smul_smul]⟩

theorem orbitRepresentatives_isCompleteGaugeFixing' :
    IsCompleteGaugeFixing' G (orbitRepresentatives (X := X) G) := by
  rintro s ⟨c, rfl⟩ t ⟨d, rfl⟩ g hg
  dsimp only at hg ⊢
  have hg' : g⁻¹ • d.out = c.out := by rw [← hg, inv_smul_smul]
  have hmk : Quotient.mk (MulAction.orbitRel G X) c.out
      = Quotient.mk (MulAction.orbitRel G X) d.out :=
    Quotient.sound ⟨g⁻¹, hg'⟩
  rw [Quotient.out_eq, Quotient.out_eq] at hmk
  rw [hmk]

/-- **A complete comprehensive gauge fixing always exists as a set.** The book's
impossibility statement is therefore not a set-theoretic one; the obstruction is
the topological one recorded below. -/
theorem exists_comprehensive_complete_gaugeFixing :
    ∃ S : Set X, IsComprehensiveGaugeFixing G S ∧ IsCompleteGaugeFixing' G S :=
  ⟨orbitRepresentatives G, orbitRepresentatives_isComprehensiveGaugeFixing G,
    orbitRepresentatives_isCompleteGaugeFixing' G⟩

end Existence

/-! ## 2. A complete comprehensive gauge fixing parametrizes the physical algebra -/

section Complete

variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

/-- On a complete comprehensive gauge fixing, each point of the spectrum has
**exactly one** gauge representative. -/
theorem existsUnique_mem_of_complete_comprehensive
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (x : X) : ∃! s : X, s ∈ S ∧ ∃ g : G, g • s = x := by
  obtain ⟨s, hsS, g, hgs⟩ := hcomp x
  refine ⟨s, ⟨hsS, g, hgs⟩, ?_⟩
  rintro t ⟨htS, h, hht⟩
  exact hcompl t htS s hsS (g⁻¹ * h) (by rw [mul_smul, hht, ← hgs, inv_smul_smul])

/-- **Completeness makes the remnant gauge symmetry vacuous.** Every function
given on a complete comprehensive gauge fixing extends to a physical (gauge
invariant) observable. -/
theorem exists_physical_extension_of_complete
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (h : X → ℝ) :
    ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s :=
  exists_physical_extension G hcomp h
    (fun s hsS t htS g hg => by rw [hcompl s hsS t htS g hg])

/-- **A complete comprehensive gauge fixing is a faithful parametrization of the
physical algebra**: restriction to it is a bijection between the gauge-invariant
observables of the spectrum and *all* functions on the gauge-fixing surface. -/
theorem existsUnique_physical_extension_of_complete
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (h : X → ℝ) :
    ∃! f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s := by
  obtain ⟨f, hf, hfS⟩ := exists_physical_extension_of_complete hcomp hcompl h
  refine ⟨f, ⟨hf, hfS⟩, ?_⟩
  rintro f' ⟨hf', hf'S⟩
  exact physical_ext_of_comprehensive G hcomp hf' hf (fun s hs => by rw [hf'S s hs, hfS s hs])

/-- **The gauge condition is not an observable.** If the gauge group acts freely
and non-trivially, the indicator function of a comprehensive gauge fixing that is
complete is never gauge invariant: choosing a gauge is extra data, it is not a
statement about the physical system. -/
theorem not_isPhysicalObservable_indicator [Nontrivial G] [Nonempty X]
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (hfree : MovesEveryPointOfSpectrum G X) :
    ¬ IsPhysicalObservable G (S.indicator (fun _ => (1 : ℝ))) := by
  intro hphys
  obtain ⟨x⟩ := ‹Nonempty X›
  obtain ⟨s, hsS, g, -⟩ := hcomp x
  obtain ⟨h, hh⟩ := exists_ne (1 : G)
  have hnot : h • s ∉ S := fun hmem => hfree h hh s (hcompl s hsS (h • s) hmem h rfl).symm
  have hval := hphys h s
  rw [Set.indicator_of_notMem hnot, Set.indicator_of_mem hsS] at hval
  exact one_ne_zero hval.symm

end Complete

/-! ## 3. The Gribov obstruction: completeness is incompatible with continuity -/

section Gribov

variable {X : Type*} [TopologicalSpace X] {G : Type*} [Group G] [MulAction G X]

/-- **The obstruction.**  On a connected spectrum, and for a gauge group acting
freely (the book's *unconstrained* condition) and non-trivially, a gauge fixing
that is both comprehensive and complete can never be *clopen*, i.e. it can never
be cut out by a continuous (locally constant) gauge condition: the gauge
equivalence classes can be crossed exactly once only by a discontinuous choice.
This is the abstract form of the Gribov ambiguity invoked in `book.tex` 2301. -/
theorem not_isClopen_of_complete_comprehensive [PreconnectedSpace X] [Nonempty X]
    [Nontrivial G] {S : Set X}
    (hcomp : IsComprehensiveGaugeFixing G S) (hcompl : IsCompleteGaugeFixing' G S)
    (hfree : MovesEveryPointOfSpectrum G X) :
    ¬ IsClopen S := by
  intro hclopen
  obtain ⟨x⟩ := ‹Nonempty X›
  obtain ⟨s, hsS, -, -⟩ := hcomp x
  obtain ⟨h, hh⟩ := exists_ne (1 : G)
  have hne : S.Nonempty := ⟨s, hsS⟩
  have hnotmem : h • s ∉ S := fun hmem => hfree h hh s (hcompl s hsS (h • s) hmem h rfl).symm
  rcases isClopen_iff.mp hclopen with hempty | huniv
  · exact absurd hempty (Set.nonempty_iff_ne_empty.mp hne)
  · exact hnotmem (huniv ▸ Set.mem_univ _)

end Gribov

/-! ## 4. The two axes are injectivity and surjectivity of the restriction -/

section Classification

variable {X : Type*} {G : Type*} [Group G] [MulAction G X] {S : Set X}

/-- If the gauge fixing is **not** comprehensive it *does* lose physical
information: two different physical observables agree on it. -/
theorem exists_physical_ne_agreeing_of_not_comprehensive
    (hS : ¬ IsComprehensiveGaugeFixing G S) :
    ∃ f f' : X → ℝ, IsPhysicalObservable G f ∧ IsPhysicalObservable G f' ∧
      (∀ s ∈ S, f s = f' s) ∧ f ≠ f' := by
  classical
  rw [IsComprehensiveGaugeFixing] at hS
  push_neg at hS
  obtain ⟨x₀, hx₀⟩ := hS
  have horb : ∀ (y : X) (g : G), y ∈ MulAction.orbit G x₀ →
      g • y ∈ MulAction.orbit G x₀ := by
    intro y g hy
    rw [MulAction.mem_orbit_iff] at hy ⊢
    obtain ⟨k, hk⟩ := hy
    exact ⟨g * k, by rw [mul_smul, hk]⟩
  refine ⟨(MulAction.orbit G x₀).indicator (fun _ => (1 : ℝ)), 0, ?_, fun _ _ => rfl, ?_, ?_⟩
  · intro g x
    by_cases hx : x ∈ MulAction.orbit G x₀
    · rw [Set.indicator_of_mem hx, Set.indicator_of_mem (horb x g hx)]
    · rw [Set.indicator_of_notMem hx, Set.indicator_of_notMem]
      intro hmem
      have hback := horb _ g⁻¹ hmem
      rw [inv_smul_smul] at hback
      exact hx hback
  · intro s hsS
    have hns : s ∉ MulAction.orbit G x₀ := by
      intro hmem
      rw [MulAction.mem_orbit_iff] at hmem
      obtain ⟨k, hk⟩ := hmem
      exact hx₀ s hsS k⁻¹ (by rw [← hk, inv_smul_smul])
    simp [Set.indicator_of_notMem hns]
  · intro hcontra
    have h₀ : (MulAction.orbit G x₀).indicator (fun _ => (1 : ℝ)) x₀ = 0 := by
      rw [hcontra]; rfl
    rw [Set.indicator_of_mem (MulAction.mem_orbit_self x₀)] at h₀
    exact one_ne_zero h₀

/-- **Comprehensiveness is exactly the losslessness of the gauge fixing.** -/
theorem physical_ext_iff_comprehensive :
    (∀ f f' : X → ℝ, IsPhysicalObservable G f → IsPhysicalObservable G f' →
        (∀ s ∈ S, f s = f' s) → f = f') ↔ IsComprehensiveGaugeFixing G S := by
  constructor
  · intro hext
    by_contra hS
    obtain ⟨f, f', hf, hf', hagree, hne⟩ :=
      exists_physical_ne_agreeing_of_not_comprehensive hS
    exact hne (hext f f' hf hf' hagree)
  · intro hS f f' hf hf' hagree
    exact physical_ext_of_comprehensive G hS hf hf' hagree

/-- If the gauge fixing is **not** complete, some function on it is not the
restriction of any physical observable: the remnant gauge symmetry constrains the
values on the gauge-fixing surface. -/
theorem exists_not_extendable_of_not_complete (hS : ¬ IsCompleteGaugeFixing' G S) :
    ∃ h : X → ℝ, ¬ ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s := by
  classical
  rw [IsCompleteGaugeFixing'] at hS
  push_neg at hS
  obtain ⟨s, hsS, t, htS, g, hgst, hst⟩ := hS
  refine ⟨({s} : Set X).indicator (fun _ => (1 : ℝ)), ?_⟩
  rintro ⟨f, hf, hfS⟩
  have hfs : f s = 1 := by
    rw [hfS s hsS, Set.indicator_of_mem (Set.mem_singleton s)]
  have hft : f t = 0 := by
    rw [hfS t htS, Set.indicator_of_notMem (by simpa [eq_comm] using hst)]
  rw [← hgst, hf g s, hfs] at hft
  exact one_ne_zero hft

/-- **Completeness is exactly the freedom to prescribe the observable on the
gauge-fixing surface.** -/
theorem physical_extension_iff_complete :
    (∀ h : X → ℝ, ∃ f : X → ℝ, IsPhysicalObservable G f ∧ ∀ s ∈ S, f s = h s) ↔
      IsCompleteGaugeFixing' G S := by
  constructor
  · intro hext
    by_contra hS
    obtain ⟨h, hh⟩ := exists_not_extendable_of_not_complete hS
    exact hh (hext h)
  · intro hS h
    classical
    have key : ∀ c : Quotient (MulAction.orbitRel G X), ∃ r : ℝ,
        ∀ s ∈ S, Quotient.mk (MulAction.orbitRel G X) s = c → r = h s := by
      intro c
      by_cases hc : ∃ s, s ∈ S ∧ Quotient.mk (MulAction.orbitRel G X) s = c
      · obtain ⟨s₀, hs₀S, hs₀c⟩ := hc
        refine ⟨h s₀, fun s hsS hsc => ?_⟩
        have hmk : Quotient.mk (MulAction.orbitRel G X) s
            = Quotient.mk (MulAction.orbitRel G X) s₀ := by rw [hsc, hs₀c]
        obtain ⟨g, hg⟩ := Quotient.exact hmk
        rw [hS s₀ hs₀S s hsS g hg]
      · exact ⟨0, fun s hsS hsc => absurd ⟨s, hsS, hsc⟩ hc⟩
    choose F hF using key
    refine ⟨fun x => F (Quotient.mk (MulAction.orbitRel G X) x), fun g x => ?_,
      fun s hsS => hF _ s hsS rfl⟩
    have hq : Quotient.mk (MulAction.orbitRel G X) (g • x)
        = Quotient.mk (MulAction.orbitRel G X) x :=
      Quotient.sound (MulAction.mem_orbit x g)
    simp only [hq]

end Classification

/-! ## 5. The spurious field of `book.tex` 7406 -/

section Spurious

variable (X : Type*) (G : Type*) [Group G] [MulAction G X]

/-- The gauge fixing obtained by adjoining a *spurious* degree of freedom that
takes values in the gauge group itself and setting it to the identity — the
manuscript's "new field `Φ` and new constraint `Π = 0`" which "allows a complete
and comprehensive gauge-fixing" (`book.tex` 7406).  The gauge group acts
diagonally on `X × G`, by the original action on `X` and by left translation on
the spurious factor. -/
def spuriousSection : Set (X × G) := {p | p.2 = 1}

/-- Adjoining the spurious field makes the gauge fixing **comprehensive**: every
configuration is gauge equivalent to one with the spurious field at the
identity. -/
theorem spuriousSection_isComprehensiveGaugeFixing :
    IsComprehensiveGaugeFixing G (spuriousSection X G) := by
  rintro ⟨x, h⟩
  refine ⟨(h⁻¹ • x, 1), rfl, h, ?_⟩
  have h1 : h • (h⁻¹ • x) = x := smul_inv_smul h x
  have h2 : h * (1 : G) = h := mul_one h
  exact Prod.ext h1 h2

/-- And **complete**: no gauge transformation other than the identity preserves
the value of the spurious field, so each equivalence class is crossed once. -/
theorem spuriousSection_isCompleteGaugeFixing' :
    IsCompleteGaugeFixing' G (spuriousSection X G) := by
  rintro ⟨x, hx⟩ hxS ⟨y, hy⟩ hyS g hg
  have hx1 : hx = 1 := hxS
  have hy1 : hy = 1 := hyS
  subst hx1; subst hy1
  have hg2 : g * (1 : G) = 1 := congrArg Prod.snd hg
  have hg1 : g = 1 := by simpa using hg2
  subst hg1
  have hfst : x = y := by simpa using congrArg Prod.fst hg
  rw [hfst]

end Spurious

/-! ## 6. The book's concrete example: translations of the line -/

section Shift

/-- The gauge group `ℤ` (written multiplicatively) acting on the spectrum `ℝ` by
translations.  This is the continuous analogue of the book's lattice example
`e_k ↦ e_{k+1}` (`book.tex` 2281–2289). -/
scoped instance shiftAction : MulAction (Multiplicative ℤ) ℝ where
  smul n x := ((Multiplicative.toAdd n : ℤ) : ℝ) + x
  one_smul x := by
    change ((0 : ℤ) : ℝ) + x = x
    simp
  mul_smul m n x := by
    change ((Multiplicative.toAdd (m * n) : ℤ) : ℝ) + x
        = ((Multiplicative.toAdd m : ℤ) : ℝ) + (((Multiplicative.toAdd n : ℤ) : ℝ) + x)
    rw [show Multiplicative.toAdd (m * n)
        = Multiplicative.toAdd m + Multiplicative.toAdd n from rfl]
    push_cast
    ring

theorem shift_smul_def (n : Multiplicative ℤ) (x : ℝ) :
    n • x = ((Multiplicative.toAdd n : ℤ) : ℝ) + x := rfl

/-- The unit cell `[0, 1)`: the standard gauge fixing of the translation gauge
symmetry of the line. -/
def unitCell : Set ℝ := Set.Ico 0 1

/-- The unit cell crosses every gauge equivalence class: it is a *comprehensive*
gauge fixing. -/
theorem unitCell_isComprehensiveGaugeFixing :
    IsComprehensiveGaugeFixing (Multiplicative ℤ) unitCell := by
  intro x
  refine ⟨Int.fract x, ⟨Int.fract_nonneg x, Int.fract_lt_one x⟩,
    Multiplicative.ofAdd ⌊x⌋, ?_⟩
  rw [shift_smul_def]
  exact Int.floor_add_fract x

/-- The unit cell crosses each gauge equivalence class at most once: it is a
*complete* gauge fixing. -/
theorem unitCell_isCompleteGaugeFixing' :
    IsCompleteGaugeFixing' (Multiplicative ℤ) unitCell := by
  rintro s ⟨hs0, hs1⟩ t ⟨ht0, ht1⟩ g hg
  rw [shift_smul_def] at hg
  have hlt : (Multiplicative.toAdd g : ℤ) < 1 := by
    have : ((Multiplicative.toAdd g : ℤ) : ℝ) < ((1 : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast this
  have hgt : (-1 : ℤ) < (Multiplicative.toAdd g : ℤ) := by
    have : (((-1 : ℤ)) : ℝ) < ((Multiplicative.toAdd g : ℤ) : ℝ) := by push_cast; linarith
    exact_mod_cast this
  have hz : (Multiplicative.toAdd g : ℤ) = 0 := by omega
  rw [hz] at hg
  simpa using hg

/-- The translation gauge symmetry is *unconstrained* in the book's sense: every
non-trivial gauge transformation moves every point of the spectrum. -/
theorem shift_movesEveryPointOfSpectrum :
    MovesEveryPointOfSpectrum (Multiplicative ℤ) ℝ := by
  intro g hg x hx
  rw [shift_smul_def] at hx
  apply hg
  have h0 : ((Multiplicative.toAdd g : ℤ) : ℝ) = 0 := by linarith
  have : (Multiplicative.toAdd g : ℤ) = 0 := by exact_mod_cast h0
  exact Multiplicative.toAdd.injective this

/-- **The Gribov ambiguity, concretely.** Complete comprehensive gauge fixings of
the translation symmetry of the line exist (the unit cell is one), but *no* such
gauge fixing is clopen: every complete gauge choice is necessarily
discontinuous. -/
theorem shift_no_clopen_complete_gaugeFixing {S : Set ℝ}
    (hcomp : IsComprehensiveGaugeFixing (Multiplicative ℤ) S)
    (hcompl : IsCompleteGaugeFixing' (Multiplicative ℤ) S) :
    ¬ IsClopen S :=
  not_isClopen_of_complete_comprehensive hcomp hcompl shift_movesEveryPointOfSpectrum

/-- In particular the unit cell itself is not clopen. -/
theorem unitCell_not_isClopen : ¬ IsClopen unitCell :=
  shift_no_clopen_complete_gaugeFixing unitCell_isComprehensiveGaugeFixing
    unitCell_isCompleteGaugeFixing'

/-- No point of the form `0` or `1` is gauge equivalent to `1/2`. -/
theorem shift_smul_ne_half {s : ℝ} (hs : s = 0 ∨ s = 1) (g : Multiplicative ℤ) :
    g • s ≠ (1 / 2 : ℝ) := by
  rw [shift_smul_def]
  intro hcontra
  have hz : ((2 * Multiplicative.toAdd g : ℤ) : ℝ) = ((1 : ℤ) : ℝ) ∨
      ((2 * Multiplicative.toAdd g : ℤ) : ℝ) = ((-1 : ℤ) : ℝ) := by
    rcases hs with hs | hs <;> subst hs <;> push_cast <;> [left; right] <;> linarith
  have hz' : 2 * Multiplicative.toAdd g = 1 ∨ 2 * Multiplicative.toAdd g = -1 := by
    rcases hz with hz | hz
    · exact Or.inl (by exact_mod_cast hz)
    · exact Or.inr (by exact_mod_cast hz)
  omega

/-- **The four kinds of gauge fixing all occur.** For the translation gauge
symmetry of the line: `[0,1)` is comprehensive and complete, the whole line is
comprehensive and incomplete, `{0}` is complete and non-comprehensive (the
situation of the book's Weyl-gauge magnetic components, `book.tex` 7427), and
`{0, 1}` is neither. -/
theorem shift_gaugeFixing_classification :
    (IsComprehensiveGaugeFixing (Multiplicative ℤ) unitCell ∧
      IsCompleteGaugeFixing' (Multiplicative ℤ) unitCell) ∧
    (IsComprehensiveGaugeFixing (Multiplicative ℤ) (Set.univ : Set ℝ) ∧
      ¬ IsCompleteGaugeFixing' (Multiplicative ℤ) (Set.univ : Set ℝ)) ∧
    (¬ IsComprehensiveGaugeFixing (Multiplicative ℤ) ({0} : Set ℝ) ∧
      IsCompleteGaugeFixing' (Multiplicative ℤ) ({0} : Set ℝ)) ∧
    (¬ IsComprehensiveGaugeFixing (Multiplicative ℤ) ({0, 1} : Set ℝ) ∧
      ¬ IsCompleteGaugeFixing' (Multiplicative ℤ) ({0, 1} : Set ℝ)) := by
  refine ⟨⟨unitCell_isComprehensiveGaugeFixing, unitCell_isCompleteGaugeFixing'⟩,
    ⟨univ_isComprehensiveGaugeFixing _,
      unconstrained_gauge_fixing_incomplete _ shift_movesEveryPointOfSpectrum⟩,
    ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩
  · intro hcomp
    obtain ⟨s, hs, g, hg⟩ := hcomp (1 / 2 : ℝ)
    exact shift_smul_ne_half (Or.inl hs) g hg
  · rintro s hs t ht g -
    rw [hs, ht]
  · intro hcomp
    obtain ⟨s, hs, g, hg⟩ := hcomp (1 / 2 : ℝ)
    rcases hs with hs | hs
    · exact shift_smul_ne_half (Or.inl hs) g hg
    · exact shift_smul_ne_half (Or.inr hs) g hg
  · intro hcompl
    have h01 : ((0 : ℝ) : ℝ) ≠ 1 := by norm_num
    refine h01 (hcompl 0 (Or.inl rfl) 1 (Or.inr rfl) (Multiplicative.ofAdd 1) ?_)
    rw [shift_smul_def]
    norm_num

/-- The gauge-fixing condition "`x` lies in the unit cell" is not a physical
observable. -/
theorem unitCell_indicator_not_isPhysicalObservable :
    ¬ IsPhysicalObservable (Multiplicative ℤ)
        (unitCell.indicator (fun _ => (1 : ℝ))) :=
  not_isPhysicalObservable_indicator unitCell_isComprehensiveGaugeFixing
    unitCell_isCompleteGaugeFixing' shift_movesEveryPointOfSpectrum

end Shift

end BookProof.ChapterGaugeComprehensiveFixing
