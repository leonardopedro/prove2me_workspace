import Mathlib
import BookProof.ChapterFreeFieldBornFiberCardGeneral
import BookProof.ChapterFreeFieldBornFiberTwo

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born fiber is maximal (exactly `2ⁿ` points) precisely for strictly
# positive (interior) distributions

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the free-field construction of §5 (`book.tex` ~line 1706) and the
Introduction's remark (`book.tex` ~line 805) that the wave function is *one
possible* parametrization of a probability distribution.

Wave 151 (`ChapterFreeFieldBornFiberCardGeneral`) computed the exact Born-fiber
count `Nat.card (bornMapSphere ⁻¹' {p}) = 2 ^ (#positive coordinates of p)`.
Wave 152 (`ChapterFreeFieldBornFiberTwo`) recorded that this is always `≥ 2`.
Wave 153 (`ChapterFreeFieldBornFiberDeterministic`) characterized the *minimal*
case (exactly two points) as the deterministic / Dirac distributions.

This wave is the dual: it characterizes exactly *when* the fiber is **maximal**,
i.e. has the full `2ⁿ` points.  Since `(posSupport p).card ≤ n` always, and the
fiber has `2 ^ (posSupport p).card` points, the fiber attains its maximum `2ⁿ`
iff *every* coordinate is strictly positive — i.e. iff `p` lies in the (relative)
**interior** of the standard simplex.  Thus the `{±1}ⁿ` sign gauge acts *freely*
(the parametrization is *most* redundant) precisely on the strictly positive
distributions.

## Main results

* `posSupport_card_eq_n_iff_pos` — for `p : Fin n → ℝ`,
  `(posSupport p).card = n ↔ ∀ k, 0 < p k`.
* `bornFiber_card_eq_two_pow_iff_posSupport` —
  `#fiber = 2 ^ n ↔ (posSupport p).card = n`.
* **headline** `bornFiber_card_eq_two_pow_iff_pos` — the Born fiber has exactly
  `2 ^ n` points iff `p` is strictly positive (interior of the simplex).

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral

namespace BookProof.ChapterFreeFieldBornFiberInterior

variable {n : ℕ}

/-
The positive support of `p` has full cardinality `n` iff every coordinate of `p`
is strictly positive.  (`posSupport p ⊆ univ` with `#univ = n`, so `card = n`
forces `posSupport p = univ`, and membership of `univ` is trivial.)
-/
theorem posSupport_card_eq_n_iff_pos {p : Fin n → ℝ} :
    (posSupport p).card = n ↔ ∀ k, 0 < p k := by
  constructor <;> intro h;
  · contrapose! h;
    exact ne_of_lt (lt_of_lt_of_le
      (Finset.card_lt_card (Finset.filter_ssubset.mpr <| by aesop)) (by simp))
  · rw [show posSupport p = Finset.univ from Finset.filter_true_of_mem fun k _ => h k,
      Finset.card_fin]

/-
The Born fiber has exactly `2 ^ n` points iff the positive support has full
cardinality `n`.  (Immediate from `bornFiber_card_general : #fiber =
2 ^ (posSupport p).card` and injectivity of `k ↦ 2 ^ k`.)
-/
theorem bornFiber_card_eq_two_pow_iff_posSupport {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ n ↔
      (posSupport (p : Fin n → ℝ)).card = n := by
  rw [ BookProof.ChapterFreeFieldBornFiberCardGeneral.bornFiber_card_general ];
  aesop

/-
**Headline.** The Born fiber is maximal — exactly `2 ^ n` wave functions — iff
the probability distribution is strictly positive (lies in the interior of the
standard simplex).  Equivalently, the `{±1}ⁿ` sign gauge acts *freely* precisely
on the strictly positive distributions.
-/
theorem bornFiber_card_eq_two_pow_iff_pos {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ n ↔
      ∀ k, 0 < (p : Fin n → ℝ) k := by
  exact bornFiber_card_eq_two_pow_iff_posSupport.trans posSupport_card_eq_n_iff_pos

end BookProof.ChapterFreeFieldBornFiberInterior
