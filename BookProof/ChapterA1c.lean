import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.Complexification
import BookProof.ChapterA1b

/-!
# Chapter A, §A.1 — the C-type and R-type classification (work-package N1)

This file continues work-package **N1** of `FORMALIZATION_ROADMAP.md` (§A.1,
Defs 9/10 and Props 11/12).  The previous passes built

* the complex inner-product structure on the complexification `Cx W` and the
  canonical conjugation `Cx.cxConj` (`BookProof/Complexification.lean`), together
  with the fact that the complexification of a real system is **C-real**
  (`cxConj_isConjugation`); and
* the order-preserving bijection between real subsystems and
  conjugation-invariant complex subsystems, giving the reduction of real
  irreducibility to the conjugation-stable complex lattice
  (`irreducible_iff_no_conj_subsystem`, `BookProof/ChapterA1b.lean`).

Here we add the *classification predicates* themselves:

* **Def 9** — the three types of an irreducible **complex** system:
  `IsCReal` (a C-conjugation exists), `IsCPseudoreal` (no C-conjugation but a
  commuting anti-unitary exists), `IsCComplex` (no commuting anti-unitary at
  all), together with the trichotomy (exactly one holds) and the fact that the
  complexification of a real system is always C-real.

* **Def 10 / Prop 12 (R-real case)** — the *R-real* real systems, i.e. those
  whose complexification is (C-real and) irreducible, and the converse half of
  the trichotomy: an R-real system is irreducible.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

/-! ## Def 9 — the C-type of a complex system -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-- An anti-unitary operator **commutes with** the complex system `M` iff it
commutes with every `m ∈ M`. -/
def CommutesAntiUnitary (M : System ℂ V) (θ : AntiUnitary V) : Prop :=
  ∀ m ∈ M.ops, ∀ x, θ (m x) = m (θ x)

/-- The complex system `M` **has a commuting anti-unitary** iff some anti-unitary
operator commutes with `M`. -/
def HasCommutingAntiUnitary (M : System ℂ V) : Prop :=
  ∃ θ : AntiUnitary V, CommutesAntiUnitary M θ

/-- **Def 9.1 (C-real).** A complex system `M` is *C-real* iff it admits a
C-conjugation (an anti-unitary **involution** commuting with `M`). -/
def IsCReal (M : System ℂ V) : Prop :=
  ∃ θ : AntiUnitary V, IsConjugation M θ

/-- **Def 9.2 (C-pseudoreal).** A complex system `M` is *C-pseudoreal* iff it has
no C-conjugation, yet some anti-unitary operator commutes with `M`. -/
def IsCPseudoreal (M : System ℂ V) : Prop :=
  ¬ IsCReal M ∧ HasCommutingAntiUnitary M

/-- **Def 9.3 (C-complex).** A complex system `M` is *C-complex* iff no
anti-unitary operator commutes with `M` at all. -/
def IsCComplex (M : System ℂ V) : Prop :=
  ¬ HasCommutingAntiUnitary M

/-- A C-conjugation is in particular a commuting anti-unitary. -/
lemma IsConjugation.commutesAntiUnitary {M : System ℂ V} {θ : AntiUnitary V}
    (h : IsConjugation M θ) : CommutesAntiUnitary M θ := h.2

/-- A C-real system has a commuting anti-unitary. -/
lemma IsCReal.hasCommutingAntiUnitary {M : System ℂ V} (h : IsCReal M) :
    HasCommutingAntiUnitary M := by
  obtain ⟨θ, hθ⟩ := h
  exact ⟨θ, hθ.commutesAntiUnitary⟩

/-- The three C-types are **exhaustive**: every complex system is C-real,
C-pseudoreal or C-complex. -/
lemma cType_exhaustive (M : System ℂ V) :
    IsCReal M ∨ IsCPseudoreal M ∨ IsCComplex M := by
  by_cases h1 : IsCReal M
  · exact Or.inl h1
  · by_cases h2 : HasCommutingAntiUnitary M
    · exact Or.inr (Or.inl ⟨h1, h2⟩)
    · exact Or.inr (Or.inr h2)

/-- C-real and C-pseudoreal are mutually exclusive. -/
lemma not_isCReal_and_isCPseudoreal (M : System ℂ V) :
    ¬ (IsCReal M ∧ IsCPseudoreal M) := fun h => h.2.1 h.1

/-- C-real and C-complex are mutually exclusive. -/
lemma not_isCReal_and_isCComplex (M : System ℂ V) :
    ¬ (IsCReal M ∧ IsCComplex M) := fun h => h.2 h.1.hasCommutingAntiUnitary

/-- C-pseudoreal and C-complex are mutually exclusive. -/
lemma not_isCPseudoreal_and_isCComplex (M : System ℂ V) :
    ¬ (IsCPseudoreal M ∧ IsCComplex M) := fun h => h.2 h.1.2

/-! ## Def 10 / Prop 12 — the R-real case -/

open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

/-- **The complexification of a real system is C-real** (Def 9.1 form).  Its
canonical conjugation `Cx.cxConj` is a C-conjugation of the complexified system.
-/
theorem cxSystem_isCReal (M : System ℝ W) : IsCReal (cxSystem M) :=
  ⟨Cx.cxConj, cxConj_isConjugation M⟩

/-- **Def 10 (R-real).** A real system `M` is *R-real* iff its complexification
`(M, Cx W)` is irreducible (as a complex system).  By `cxSystem_isCReal` the
complexification is automatically C-real, so this matches Def 10's "C-real
irreducible complexification". -/
def IsRReal (M : System ℝ W) : Prop :=
  (cxSystem M).IsIrreducible

/-- The complexification of an R-real system is C-real (unpacking the definition,
this is `cxSystem_isCReal`). -/
theorem IsRReal.cxSystem_isCReal {M : System ℝ W} (_ : IsRReal M) :
    IsCReal (cxSystem M) :=
  _root_.BookProof.ChapterA.cxSystem_isCReal M

/-- **Prop 12 (R-real case).**  An R-real real system is irreducible.  If the
complexification `(M, Cx W)` is irreducible as a complex system then in
particular it has no proper non-trivial *conjugation-invariant* subsystem, so by
`irreducible_iff_no_conj_subsystem` the real system `(M, W)` is irreducible. -/
theorem IsRReal.isIrreducible {M : System ℝ W} (h : IsRReal M) :
    M.IsIrreducible := by
  rw [irreducible_iff_no_conj_subsystem]
  intro X hX _
  exact h X hX

end BookProof.ChapterA
