import Mathlib
import BookProof.ChapterFreeFieldBornFiberCardGeneral
import BookProof.ChapterFreeFieldBornFiberTwo

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the Born fiber is minimal (exactly two points) precisely for deterministic
# (Dirac / vertex) distributions

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the free-field construction of §5 (`book.tex` ~line 1706) and the
Introduction's remark (`book.tex` ~line 805) that the wave function is *one
possible* parametrization of a probability distribution.

Wave 151 (`ChapterFreeFieldBornFiberCardGeneral`) computed the exact Born-fiber
count `Nat.card (bornMapSphere ⁻¹' {p}) = 2 ^ (#positive coordinates of p)`.
Wave 152 (`ChapterFreeFieldBornFiberTwo`) recorded that this is always `≥ 2`.

This wave characterizes exactly *when* the lower bound `2` is attained: the Born
fiber has **exactly two** points iff the probability distribution has **exactly
one** strictly positive coordinate, i.e. iff it is a **deterministic** (Dirac)
distribution — a *vertex* of the standard simplex `p = 𝟙_{k = i}`. Thus the
wave-function parametrization is "least redundant" (only the global `±1` sign
remains) precisely on the deterministic distributions, and strictly more
redundant on every genuinely mixed distribution.

## Main results

* `bornFiber_card_eq_two_iff_posSupport` — `#fiber = 2 ↔ #positive coords = 1`.
* `posSupport_card_one_iff_deterministic` — for a probability distribution,
  `#positive coords = 1 ↔ p` is a Dirac distribution `fun k => if k = i then 1
  else 0`.
* **headline** `bornFiber_card_eq_two_iff_deterministic` — the Born fiber has
  exactly two points iff `p` is deterministic.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral

namespace BookProof.ChapterFreeFieldBornFiberDeterministic

variable {n : ℕ}

/-
The Born fiber has exactly two points iff the probability distribution has
exactly one strictly positive coordinate.  (Immediate from
`bornFiber_card_general : #fiber = 2 ^ (posSupport p).card` and the injectivity
of `k ↦ 2 ^ k`.)
-/
theorem bornFiber_card_eq_two_iff_posSupport {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ↔ (posSupport (p : Fin n → ℝ)).card = 1 := by
  rw [ BookProof.ChapterFreeFieldBornFiberCardGeneral.bornFiber_card_general ];
  exact ⟨ fun h => Nat.pow_right_injective ( by decide ) h, fun h => h.symm ▸ rfl ⟩

/-
For a probability distribution, having exactly one strictly positive
coordinate is the same as being a deterministic (Dirac) distribution: the
indicator of a single index `i`.  Indeed the off-support coordinates are
non-negative and not positive, hence zero, so the sum constraint forces the
single surviving coordinate to equal `1`.
-/
theorem posSupport_card_one_iff_deterministic {p : Fin n → ℝ}
    (hp : p ∈ stdSimplex ℝ (Fin n)) :
    (posSupport p).card = 1 ↔ ∃ i, p = fun k => if k = i then (1 : ℝ) else 0 := by
  constructor <;> intro h_card;
  · obtain ⟨ i, hi ⟩ := Finset.card_eq_one.mp h_card;
    use i;
    ext k; by_cases hk : k = i <;> simp_all only [posSupport, Finset.ext_iff, Finset.mem_filter,
        Finset.mem_univ, true_and, Finset.mem_singleton, ↓reduceIte] ;
    · have h_sum : ∑ k ∈ Finset.univ.erase i, p k = 0 := by
        exact Finset.sum_eq_zero fun x hx =>
          le_antisymm ( le_of_not_gt fun hx' => by have := hi x; aesop ) ( hp.1 x );
      simp_all ;
      linarith [ hp.2 ];
    · exact le_antisymm ( le_of_not_gt fun h => hk <| hi k |>.1 h ) ( hp.1 k );
  · obtain ⟨ i, rfl ⟩ := h_card; simp only [posSupport] ;
    rw [ Finset.card_eq_one ] ; use i ; ext k ; aesop

/-
**Headline.** The Born fiber is minimal — exactly two wave functions — iff
the probability distribution is deterministic (a Dirac / vertex of the standard
simplex).  Equivalently, the wave-function parametrization carries *only* the
global `±1` sign gauge precisely on the deterministic distributions.
-/
theorem bornFiber_card_eq_two_iff_deterministic {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ↔
      ∃ i, (p : Fin n → ℝ) = fun k => if k = i then (1 : ℝ) else 0 := by
  convert bornFiber_card_eq_two_iff_posSupport using 1;
  convert posSupport_card_one_iff_deterministic p.2 |> Iff.symm using 1

end BookProof.ChapterFreeFieldBornFiberDeterministic
