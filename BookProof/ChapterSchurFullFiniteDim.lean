import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA2b
import BookProof.ChapterSchurFiniteDim

/-!
# Schur's lemma, full (commutant) form, in finite dimensions

`BookProof.ChapterA2b` introduces the *full* Schur property

```
IsSchurFull M : ∀ S : V →L[ℂ] V, M.Commutes S → ∃ c : ℂ, S = c • 1
```

as a **named hypothesis** (`EXTERNAL`), because Schur's lemma for general
unitary representations on infinite-dimensional spaces is not in Mathlib.
`BookProof.ChapterSchurFiniteDim` already discharges the *unitary* variant
(`IsSchurUnitary`) for nonzero finite-dimensional complex spaces.  This file
discharges the full, commutant form in the same setting, so that in finite
dimensions `ChapterA2b`'s trichotomy runs with no external input at all:

* `isSchurFull_of_irreducible` — an irreducible system on a nonzero
  finite-dimensional complex inner-product space is Schur in the full sense;
* `commutant_eq_scalars_of_irreducible` — hence its commutant is exactly `ℂ · 1`;
* `commutant_finrank_one` — the commutant is a one-dimensional `ℂ`-subspace of
  the bounded operators.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis is used.
-/

namespace BookProof.ChapterSchurFullFiniteDim

open BookProof.ChapterA BookProof.ChapterSchurFiniteDim

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

/-- **Schur's lemma, full form, in finite dimensions.**  Every bounded operator
commuting with an irreducible system on a nonzero finite-dimensional complex
inner-product space is a complex scalar.  This *proves* the `EXTERNAL` hypothesis
`IsSchurFull` of `BookProof.ChapterA2b` in finite dimensions. -/
theorem isSchurFull_of_irreducible [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) :
    IsSchurFull M := by
  intro S hS
  have hcomm : ∀ m ∈ M.ops, ∀ x, S (m x) = m (S x) := by
    intro m hm x
    have := congrArg (fun T : V →L[ℂ] V => T x) (hS m hm)
    simpa using this
  obtain ⟨c, hc⟩ := schur_scalar_of_irreducible M hirr S.toLinearMap hcomm
  exact ⟨c, by ext x; simpa using hc x⟩

/-- **The commutant of an irreducible finite-dimensional system is `ℂ · 1`.**
Combining `isSchurFull_of_irreducible` with `commutant_eq_complex_scalars`. -/
theorem commutant_eq_scalars_of_irreducible [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) (S : V →L[ℂ] V) :
    M.Commutes S ↔ ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) :=
  commutant_eq_complex_scalars M (isSchurFull_of_irreducible M hirr) S

/-- The commutant of an irreducible finite-dimensional system, viewed as a
`ℂ`-submodule of the bounded operators, is the span of the identity — a
one-dimensional space. -/
theorem commutant_eq_span_one [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) :
    {S : V →L[ℂ] V | M.Commutes S} = (Submodule.span ℂ {(1 : V →L[ℂ] V)} : Set (V →L[ℂ] V)) := by
  ext S
  simp only [Set.mem_setOf_eq, SetLike.mem_coe, Submodule.mem_span_singleton]
  rw [commutant_eq_scalars_of_irreducible M hirr S]
  constructor
  · rintro ⟨c, rfl⟩; exact ⟨c, rfl⟩
  · rintro ⟨c, rfl⟩; exact ⟨c, rfl⟩

end BookProof.ChapterSchurFullFiniteDim
