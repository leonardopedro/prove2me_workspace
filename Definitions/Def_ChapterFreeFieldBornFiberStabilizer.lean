import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib


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



/-- The **stabilizer** of `x` in the diagonal `{±1}ⁿ` sign group, indexed by
boolean sign choices: those sign flips that fix `x`. -/
noncomputable def signStab (x : EuclideanSpace ℝ (Fin n)) : Finset (Fin n → Bool) :=
  Finset.univ.filter (fun b => signFlip (boolSign b) x = x)

/-
A sign flip fixes `x` iff it is `+1` on every nonzero coordinate of `x`.
-/
e := by simpa using hb
          have hz0 : x.ofLp k = 0 := by linarith [h hbf]
          exact absurd hz0 hk;
      · ext k; by_cases hk : x.ofLp k = 0 <;> simp_all [ boolSign ] ;

/-
The stabili        · intro hb; use Finset.univ.filter (fun k => b k = false); simp_all ;
          intro k hkb
          simp at hkb
          by_contra hnz
          s`2 ^ (#nonzero coordinates)` equals the order `2 ^ n` of the diagonal sign
group.
-/
theorem signStab_card_mul_two_pow_nonzero (x : Ero coordinates of `x`
(since `bornMap x k = (x k)² > 0 ↔ x k ≠ 0`).
-/
theorem posSupport_bornMap (x : EuclideanSpace ℝ (Fin n)) :
    posSupport (bornMap x) = Finset.univ.filter (fun k => x k ≠ 0) := by
      ext k; simp only [posSupport, FinsignStab_card
    (x : ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1)) :
    Nat.card ↥(bornMapSphere n ⁻¹' {bornMapSphere n x}) *
        (signStab (x : EuclideanSpace ℝ (Fin n))).card = 2 ^ n := by
  rw [mul_comm, ← signStab_card_mul_two_pow_nonzero]
  congr 1
  rw [bornFiber_card_general, bornMapSphere_coe, posSupport_bornMap]

end BookProof.ChapterFreeFieldBornFiberStabilizer
