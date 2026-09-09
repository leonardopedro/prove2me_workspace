import Mathlib
import BookProof.ChapterFreeFieldBornFiberBounds

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the full spectrum of Born-fiber cardinalities

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the free-field construction of §5 (`book.tex` ~line 1706) and the
Introduction's remark (`book.tex` ~line 805) that the wave function is *one
possible* parametrization of a probability distribution.

Waves 151–155 computed the exact Born-fiber count
`Nat.card (bornMapSphere ⁻¹' {p}) = 2 ^ (#positive coordinates of p)`, gave the
sharp two-sided bound `2 ≤ #fiber ≤ 2ⁿ`, and characterized the two extremes.

This wave records the **structural shape** of the fiber cardinality and pins
down the *entire spectrum* of values it takes:

* every fiber size is an **even power of two** dividing `2ⁿ`;
* the fiber size is **monotone** in the positive support;
* and — building an explicit `k`-point uniform distribution — **every** value
  `2ᵏ` with `1 ≤ k ≤ n` is attained, and no others.  Hence the set of achievable
  fiber cardinalities is exactly `{2ᵏ : 1 ≤ k ≤ n}`.

## Main results

* `bornFiber_card_even` — `2 ∣ #fiber`.
* `bornFiber_card_isPowerOfTwo` — `∃ k, 1 ≤ k ∧ k ≤ n ∧ #fiber = 2 ^ k`.
* `bornFiber_card_dvd_two_pow_n` — `#fiber ∣ 2 ^ n`.
* `bornFiber_card_mono` — `posSupport p ⊆ posSupport q → #fiber p ≤ #fiber q`.
* `unifDist` — the uniform distribution on the first `k` coordinates, with
  `posSupport` of cardinality `k`.
* `exists_bornFiber_card_eq_two_pow` — for `1 ≤ k ≤ n` some distribution has
  fiber cardinality `2 ^ k`.
* **headline** `bornFiber_card_achievable_iff` — a number `c` is the cardinality
  of some Born fiber iff `c = 2 ^ k` for some `1 ≤ k ≤ n`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberBounds

namespace BookProof.ChapterFreeFieldBornFiberSpectrum

variable {n : ℕ}

/-
Every Born fiber has an even number of points: the global `±1` sign is
always a free involution, so the exponent `#positive coords` is at least `1`.
-/
theorem bornFiber_card_even {p : ↥(stdSimplex ℝ (Fin n))} :
    2 ∣ Nat.card ↥(bornMapSphere n ⁻¹' {p}) := by
  rw [ bornFiber_card_general ];
  exact dvd_pow_self _ ( Nat.ne_of_gt ( one_le_posSupport_card p.2 ) )

/-
The Born-fiber cardinality is a power of two with exponent between `1` and
`n`: exactly `2 ^ (#positive coords)` with `1 ≤ #positive coords ≤ n`.
-/
theorem bornFiber_card_isPowerOfTwo {p : ↥(stdSimplex ℝ (Fin n))} :
    ∃ k, 1 ≤ k ∧ k ≤ n ∧ Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ k := by
  exact ⟨ _, BookProof.ChapterFreeFieldBornFiberTwo.one_le_posSupport_card p.2,
      BookProof.ChapterFreeFieldBornFiberBounds.posSupport_card_le_n,
          BookProof.ChapterFreeFieldBornFiberCardGeneral.bornFiber_card_general ⟩

/-- Every Born fiber cardinality divides `2 ^ n`. -/
theorem bornFiber_card_dvd_two_pow_n {p : ↥(stdSimplex ℝ (Fin n))} :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) ∣ 2 ^ n := by
  rw [bornFiber_card_general]
  exact pow_dvd_pow 2 posSupport_card_le_n

/-
The Born-fiber cardinality is monotone in the positive support: a
distribution with a larger positive support has at least as many wave
functions.
-/
theorem bornFiber_card_mono {p q : ↥(stdSimplex ℝ (Fin n))}
    (h : posSupport (p : Fin n → ℝ) ⊆ posSupport (q : Fin n → ℝ)) :
    Nat.card ↥(bornMapSphere n ⁻¹' {p}) ≤ Nat.card ↥(bornMapSphere n ⁻¹' {q}) := by
  convert Nat.pow_le_pow_right ( by norm_num : 1 ≤ 2 ) ( Finset.card_le_card h ) using 1;
  · convert bornFiber_card_general using 1;
  · convert BookProof.ChapterFreeFieldBornFiberCardGeneral.bornFiber_card_general

/-- The uniform distribution supported on the first `k` coordinates. -/
noncomputable def unifDist (n k : ℕ) : Fin n → ℝ :=
  fun j => if (j : ℕ) < k then (1 : ℝ) / k else 0

/-
For `1 ≤ k ≤ n`, `unifDist n k` is a probability distribution.
-/
theorem unifDist_mem_simplex {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    unifDist n k ∈ stdSimplex ℝ (Fin n) := by
  constructor;
  · exact fun x => by unfold unifDist; split_ifs <;> positivity;
  · unfold unifDist;
    norm_num [ Finset.sum_ite ];
    rw [ show ( Finset.univ.filter fun x : Fin n => ( x : ℕ ) < k ).card = k from ?_,
        mul_inv_cancel₀ ( by positivity ) ];
    rw [ Finset.card_eq_of_bijective ];
    focus (use fun i hi => ⟨ i, by linarith ⟩);
    · grind;
    · grind;
    · lia

/-
For `1 ≤ k ≤ n`, `unifDist n k` has exactly `k` strictly positive
coordinates.
-/
theorem posSupport_unifDist_card {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    (posSupport (unifDist n k)).card = k := by
  convert Finset.card_eq_sum_ones ( Finset.Iio k ) using 1;
  · refine Finset.card_bij ( fun x hx => x.1 ) ?_ ?_ ?_ <;> simp only [posSupport,
      Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_Iio, exists_prop];
    · unfold unifDist; aesop;
    · exact fun a₁ ha₁ a₂ ha₂ h => Fin.ext h;
    · intro b hb; use ⟨ b, by linarith ⟩ ; simp [ unifDist, hb ] ;
      linarith;
  · norm_num

/-
For every `1 ≤ k ≤ n` there is a probability distribution whose Born fiber
has exactly `2 ^ k` points — the uniform distribution on the first `k`
coordinates.
-/
theorem exists_bornFiber_card_eq_two_pow {k : ℕ} (hk : 1 ≤ k) (hkn : k ≤ n) :
    ∃ p : ↥(stdSimplex ℝ (Fin n)),
      Nat.card ↥(bornMapSphere n ⁻¹' {p}) = 2 ^ k := by
  use ⟨unifDist n k, unifDist_mem_simplex hk hkn⟩;
  convert bornFiber_card_general;
  exact Eq.symm ( posSupport_unifDist_card hk hkn )

/-
**Headline.** The set of achievable Born-fiber cardinalities is exactly
`{2 ^ k : 1 ≤ k ≤ n}`: a number `c` is the cardinality of some Born fiber iff
`c = 2 ^ k` for some `k` with `1 ≤ k ≤ n`.
-/
theorem bornFiber_card_achievable_iff {c : ℕ} :
    (∃ p : ↥(stdSimplex ℝ (Fin n)), Nat.card ↥(bornMapSphere n ⁻¹' {p}) = c) ↔
      ∃ k, 1 ≤ k ∧ k ≤ n ∧ c = 2 ^ k := by
  constructor
  · rintro ⟨p, rfl⟩
    obtain ⟨k, hk₁, hk₂, hk⟩ := bornFiber_card_isPowerOfTwo (p := p)
    exact ⟨k, hk₁, hk₂, hk⟩
  · rintro ⟨k, hk₁, hk₂, rfl⟩
    exact exists_bornFiber_card_eq_two_pow hk₁ hk₂

end BookProof.ChapterFreeFieldBornFiberSpectrum
