import Mathlib
import BookProof.ChapterFreeFieldBornFiberBounds
import BookProof.ChapterFreeFieldBornSignGauge

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the orbit–stabilizer identity for the Born sign gauge

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"* — the free-field construction of §5 (`book.tex` ~line 1706) and the
Introduction's remark (`book.tex` ~line 805) that the wave function is *one
possible* parametrization of a probability distribution.

Earlier waves established that the diagonal `{±1}ⁿ` sign group acts on the unit
sphere with `bornMap (signFlip s x) = bornMap x`, that each Born fiber is a full
orbit of the sign group restricted to the positive support, and that
`#fiber = 2 ^ (#positive coordinates)`.

This wave records the **orbit–stabilizer** picture of that action. Indexing the
sign group by boolean choices (`boolSign`), for a fixed wave function `x` on the
sphere the **stabilizer** — the sign flips that fix `x` — is exactly the flips
supported on the *vanishing* coordinates of `x`, so it has `2 ^ (#zero
coordinates)` elements. Combined with the fiber (= orbit) count this yields the
orbit–stabilizer identity `#orbit · #stabilizer = 2 ^ n`, the order of the whole
diagonal sign group.

## Main results

* `boolSign_pm` — `boolSign b k = ±1`.
* `mem_signStab` — `b ∈ signStab x ↔ ∀ k, x k ≠ 0 → b k = true`.
* `signStab_card` — `#(signStab x) = 2 ^ (#zero coordinates of x)`.
* `signStab_card_mul_two_pow_nonzero` — `#stabilizer · 2 ^ (#nonzero) = 2 ^ n`.
* `posSupport_bornMap` — `posSupport (bornMap x) = {k : x k ≠ 0}`.
* **headline** `bornFiber_card_mul_signStab_card` — `#fiber · #stabilizer = 2ⁿ`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberBounds

namespace BookProof.ChapterFreeFieldBornFiberStabilizer

variable {n : ℕ}

/-- The `±1` sign vector determined by a boolean choice on each coordinate. -/
def boolSign (b : Fin n → Bool) : Fin n → ℝ := fun k => if b k then 1 else -1

theorem boolSign_pm (b : Fin n → Bool) (k : Fin n) :
    boolSign b k = 1 ∨ boolSign b k = -1 := by
  unfold boolSign; split_ifs <;> simp

/-- The **stabilizer** of `x` in the diagonal `{±1}ⁿ` sign group, indexed by
boolean sign choices: those sign flips that fix `x`. -/
noncomputable def signStab (x : EuclideanSpace ℝ (Fin n)) : Finset (Fin n → Bool) :=
  Finset.univ.filter (fun b => signFlip (boolSign b) x = x)

/-
A sign flip fixes `x` iff it is `+1` on every nonzero coordinate of `x`.
-/
theorem mem_signStab {x : EuclideanSpace ℝ (Fin n)} {b : Fin n → Bool} :
    b ∈ signStab x ↔ ∀ k, x k ≠ 0 → b k = true := by
      simp only [signStab, Finset.mem_filter, Finset.mem_univ, true_and, ne_eq];
      constructor <;> intro h <;> simp_all only [signFlip, WithLp.equiv_symm_apply];
      · intro k hk; replace h := congr_arg ( fun f => f k ) h; simp_all [ boolSign ] ;
        grind;
      · ext k; by_cases hk : x.ofLp k = 0 <;> simp_all [ boolSign ] ;

/-
The stabilizer of `x` under the sign gauge has `2 ^ (#zero coordinates)`
elements: the sign choices on the vanishing coordinates are free, while the
nonzero coordinates are forced to `+1`.
-/
theorem signStab_card (x : EuclideanSpace ℝ (Fin n)) :
    (signStab x).card = 2 ^ (Finset.univ.filter (fun k => x k = 0)).card := by
      -- The stabilizer of `x` under the sign gauge has `2 ^ (#zero coordinates)` elements: the sign
      -- choices on the vanishing coordinates are free, while the nonzero coordinates are forced to
      -- `+1`.
      have h_stabilizer : signStab x = Finset.univ.filter (fun b : Fin n → Bool => ∀ k, x k ≠ 0 → b
          k = true) := by
        ext b;
        simp [ mem_signStab ];
      rw [ h_stabilizer, show ( Finset.univ.filter fun b : Fin n → Bool => ∀ k : Fin n, x.ofLp k ≠ 0
          → b k = true ) = Finset.image ( fun b : Finset ( Fin n ) => fun k => if k ∈ b then false
              else true ) ( Finset.powerset ( Finset.univ.filter fun k => x.ofLp k = 0 ) ) from ?_,
                  Finset.card_image_of_injective ];
      · rw [ Finset.card_powerset ];
      · intro a b h; ext k; have hk2 := congr_fun h k
        by_cases hk : k ∈ a <;> by_cases hk' : k ∈ b <;> simp_all
      · ext b; simp only [ne_eq, Finset.mem_filter, Finset.mem_univ, true_and, Bool.if_true_right,
          Bool.or_false, Finset.mem_image, Finset.mem_powerset];
        constructor;
        · intro hb; use Finset.univ.filter (fun k => b k = false); simp_all ;
          grind;
        · rintro ⟨ a, ha, rfl ⟩ k hk; specialize ha; replace ha := @ha k; aesop;

/-
**Orbit–stabilizer (arithmetic form).** The stabilizer size times
`2 ^ (#nonzero coordinates)` equals the order `2 ^ n` of the diagonal sign
group.
-/
theorem signStab_card_mul_two_pow_nonzero (x : EuclideanSpace ℝ (Fin n)) :
    (signStab x).card * 2 ^ (Finset.univ.filter (fun k => x k ≠ 0)).card = 2 ^ n := by
      rw [ signStab_card, ← pow_add, Finset.card_filter_add_card_filter_not ];
      norm_num

/-
`posSupport (bornMap x)` is exactly the set of nonzero coordinates of `x`
(since `bornMap x k = (x k)² > 0 ↔ x k ≠ 0`).
-/
theorem posSupport_bornMap (x : EuclideanSpace ℝ (Fin n)) :
    posSupport (bornMap x) = Finset.univ.filter (fun k => x k ≠ 0) := by
      ext k; simp only [posSupport, Finset.mem_filter, Finset.mem_univ, true_and, ne_eq];
      unfold bornMap; simp [ sq_pos_iff ] ;

/-
**Headline (orbit–stabilizer).** For a wave function `x` on the unit sphere,
the Born fiber over `bornMapSphere x` (the orbit of the sign gauge) times the
sign-gauge stabilizer of `x` equals the order `2 ^ n` of the whole diagonal sign
group.
-/
theorem bornFiber_card_mul_signStab_card
    (x : ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1)) :
    Nat.card ↥(bornMapSphere n ⁻¹' {bornMapSphere n x}) *
        (signStab (x : EuclideanSpace ℝ (Fin n))).card = 2 ^ n := by
  rw [mul_comm, ← signStab_card_mul_two_pow_nonzero]
  congr 1
  rw [bornFiber_card_general, bornMapSphere_coe, posSupport_bornMap]

end BookProof.ChapterFreeFieldBornFiberStabilizer
