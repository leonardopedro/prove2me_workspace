import Mathlib
import BookProof.ChapterFreeFieldBornFiberCardGeneral
import BookProof.ChapterFreeFieldBornFiberTwo

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# sharp bounds `2 ≤ #fiber ≤ 2ⁿ`, and equal fiber size ⇔ equal positive support

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the free-field construction of §5 (`book.tex` ~line 1706) and the
Introduction's remark (`book.tex` ~line 805) that the wave function is *one
possible* parametrization of a probability distribution.

Wave 151 (`ChapterFreeFieldBornFiberCardGeneral`) computed the exact Born-fiber
count `Nat.card (bornMapSphere ⁻¹' {p}) = 2 ^ (#positive coordinates of p)`.
Wave 152 recorded the lower bound `≥ 2`; Wave 153 / 154 characterized the two
extremes (minimal `= 2` ⇔ deterministic, maximal `= 2ⁿ` ⇔ strictly positive).

This wave assembles the picture into the **sharp two-sided bound**
`2 ≤ #fiber ≤ 2ⁿ` valid for *every* probability distribution `p`, and records
that the Born fiber size is a *complete invariant of the size of the positive
support*: two distributions have the same number of wave functions iff they have
the same number of strictly positive coordinates.

## Main results

* `posSupport_card_le_n` — `(posSupport p).card ≤ n`.
* `bornFiber_card_le_two_pow_n` — `#fiber ≤ 2 ^ n`.
* **headline** `bornFiber_card_bounds` — `2 ≤ #fiber ∧ #fiber ≤ 2 ^ n`.
* `bornFiber_card_eq_iff_posSupport_card_eq` — `#fiber p = #fiber q ↔
  (posSupport p).card = (posSupport q).card`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo

namespace BookProof.ChapterFreeFieldBornFiberBounds

variable {n : ℕ}

/-- The positive support is a subset of all `n` coordinates, so its cardinality
is at most `n`. -/
theorem posSupport_card_le_n {p : Fin n → ℝ} : (posSupport p).card ≤ n := by
  simpa using Finset.card_filter_le Finset.univ (fun k => 0 < p k)

/-- Every Born fiber has at most `2 ^ n` points: the `{±1}ⁿ` sign gauge acts
freely only on the positive support, whose size is at most `n`. -/
theorem bornFiber_card_le_two_pow_n {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) ≤ 2 ^ n := by
  rw [bornFiber_card_general]
  exact Nat.pow_le_pow_right (by decide) posSupport_card_le_n

/-
**Headline.** Sharp two-sided bound on the Born fiber, valid for every
probability distribution: at least two wave functions (the global `±1` sign is
always free) and at most `2 ^ n` (the full sign group on all coordinates).  Both
bounds are attained — the lower one exactly at the deterministic distributions
(Wave 153) and the upper one exactly at the strictly positive ones (Wave 154).
-/
theorem bornFiber_card_bounds {p : ↥(stdSimplex ℝ (Fin n))} :
    2 ≤ Nat.card ↥(bornMapSphere n ⁻¹' {p}) ∧
      Nat.card ↥(bornMapSphere n ⁻¹' {p}) ≤ 2 ^ n :=
  ⟨two_le_bornFiber_card, bornFiber_card_le_two_pow_n⟩

/-
The Born fiber size is a complete invariant of the *size of the positive
support*: two probability distributions have the same number of wave functions
iff they have the same number of strictly positive coordinates.  (Immediate from
`bornFiber_card_general` and injectivity of `k ↦ 2 ^ k` on `ℕ`.)
-/
theorem bornFiber_card_eq_iff_posSupport_card_eq
    {p q : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = Nat.card ↥(bornMapSphere n ⁻¹' {q}) ↔
      (posSupport (p : Fin n → ℝ)).card = (posSupport (q : Fin n → ℝ)).card := by
  rw [bornFiber_card_general, bornFiber_card_general]
  exact (Nat.pow_right_injective (le_refl 2)).eq_iff

end BookProof.ChapterFreeFieldBornFiberBounds
