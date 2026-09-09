import Mathlib
import BookProof.ChapterFreeFieldBornFiberCardGeneral

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# every Born fiber has at least two points; the Born map is never injective

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the Introduction's statement (`book.tex` ~line 805) that the
wave-function is *one possible* parametrization of a probability distribution,
together with the free-field construction of §5 (`book.tex` ~line 1706).

Wave 151 (`ChapterFreeFieldBornFiberCardGeneral`) computed the exact Born-fiber
count for *every* probability distribution `p`:
`Nat.card (bornMapSphere ⁻¹' {p}) = 2 ^ (#positive coordinates of p)`.

This wave draws the qualitative consequence emphasized by the book: since every
probability distribution has *at least one* strictly positive coordinate (its
coordinates are non-negative and sum to `1`), the exponent is always `≥ 1`, so
**every** Born fiber contains **at least two** wave functions.  In particular the
Born (wave-function) parametrization of a probability distribution is *never*
unique: the map `bornMapSphere` is not injective in any dimension `n ≥ 1`.  This
is the precise sense in which the wave function carries a genuine `±1` sign
(phase) gauge freedom beyond the probability distribution it represents.

## Main results

* `posSupport_nonempty` — the positive support of a probability distribution is
  nonempty.
* `one_le_posSupport_card` — hence `1 ≤ #positive coordinates`.
* **headline** `two_le_bornFiber_card` — every Born fiber has `≥ 2` points.
* `bornMapSphere_not_injective` — for `n ≥ 1` the Born map on the sphere is not
  injective.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral

namespace BookProof.ChapterFreeFieldBornFiberTwo

variable {n : ℕ}

/-
The positive support of a probability distribution is nonempty: the
coordinates are non-negative and sum to `1`, so at least one is strictly
positive.
-/
theorem posSupport_nonempty {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    (posSupport p).Nonempty := by
  by_contra h_empty;
  simp_all only [posSupport, Finset.not_nonempty_iff_eq_empty, Finset.ext_iff, Finset.mem_filter,
      Finset.mem_univ, true_and, Finset.notMem_empty, iff_false, not_lt];
  exact absurd ( hp.2 ▸ Finset.sum_nonpos fun i _ => h_empty i ) ( by norm_num )

/-- Hence a probability distribution has at least one strictly positive
coordinate. -/
theorem one_le_posSupport_card {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    1 ≤ (posSupport p).card :=
  (posSupport_nonempty hp).card_pos

/-
**Headline.** Every Born fiber contains at least two wave functions: the
`±1` sign gauge acts freely on the (nonempty) positive support of `p`, so the
fiber has `2 ^ (#positive coords) ≥ 2` points.
-/
theorem two_le_bornFiber_card {p : ↥(stdSimplex ℝ (Fin n))} :
    2 ≤ Nat.card ↥(bornMapSphere n ⁻¹' {p}) := by
  convert Nat.pow_le_pow_right ( by decide : 1 ≤ 2 ) ( one_le_posSupport_card p.2 ) using 1;
  convert bornFiber_card_general

/-
For `n ≥ 1` the wave-function (Born) parametrization is not unique: the Born
map on the unit sphere is not injective.
-/
theorem bornMapSphere_not_injective (hn : 0 < n) :
    ¬ Function.Injective (bornMapSphere n) := by
  unfold bornMapSphere; intro h; simp_all only [Function.Injective, Subtype.mk.injEq,
      Subtype.forall, mem_sphere_iff_norm, sub_zero]
  contrapose! h
  refine ⟨EuclideanSpace.single ⟨0, hn⟩ 1, ?_, -EuclideanSpace.single ⟨0, hn⟩ 1, ?_, ?_, ?_⟩ <;>
    norm_num [EuclideanSpace.norm_eq]
  · ext; simp [bornMap]
  · exact ne_of_apply_ne (fun x => x ⟨0, hn⟩) (by norm_num)

end BookProof.ChapterFreeFieldBornFiberTwo
