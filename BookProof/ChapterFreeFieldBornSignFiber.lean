import Mathlib
import BookProof.ChapterFreeFieldBornSignGauge

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the sign gauge group is the *whole* Born fiber

Source: `book.tex`, Introduction, section *"Wave-function collapse versus Euler's
formula"* (`book.tex` line ~805): *"the wave-function is nothing else than one
possible parametrization of any probability distribution; … **Two wave-functions
are always related by a rotation of the hypersphere** …"* together with the
free-field construction of §5 (`book.tex` ~line 1706).

Wave 145 (`ChapterFreeFieldBornSignGauge`) showed that the diagonal `{±1}ⁿ`
sign group is *contained* in every Born fiber: `bornMap (signFlip s x) =
bornMap x`.  This wave records the exact converse: the sign group is *precisely*
the Born fiber over `bornMap x`.  Indeed `bornMap y = bornMap x` says
`(y_k)² = (x_k)²` for all `k`, i.e. `y_k = ± x_k`; choosing `s_k = +1` where
`y_k = x_k` and `s_k = -1` otherwise gives a `±1` sign vector with
`y = signFlip s x`.  (No non-degeneracy hypothesis on `x` is needed: even at a
vanishing coordinate `x_k = 0` both sign choices reproduce `y_k = 0`.)  So the
gauge redundancy of the wave-function parametrization is *exactly* the
coordinate-wise sign freedom, with no more and no less.

Along the way we record that the sign flips form a group action of the pointwise
multiplicative structure on sign vectors: `signFlip` has an identity
(`signFlip_one`) and composes (`signFlip_comp`); in particular each `±1` flip is
an involution (`signFlip_involutive`).

## Main results

* `signFlip_one` — the constant `+1` sign vector acts as the identity.
* `signFlip_comp` — sign flips compose by pointwise multiplication of signs.
* `signFlip_involutive` — a `±1` sign flip is its own inverse.
* **headline** `bornMap_eq_iff_signFlip` — `bornMap y = bornMap x` iff
  `y = signFlip s x` for some `±1` sign vector `s`: the sign group is exactly the
  Born fiber over `bornMap x`.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSignGauge

namespace BookProof.ChapterFreeFieldBornSignFiber

variable {n : ℕ}

/-- The constant `+1` sign vector acts as the identity on wave functions. -/
theorem signFlip_one (x : EuclideanSpace ℝ (Fin n)) :
    signFlip (fun _ => 1) x = x := by
  ext k; simp [signFlip]

/-- Sign flips compose by pointwise multiplication of the sign vectors. -/
theorem signFlip_comp (s t : Fin n → ℝ) (x : EuclideanSpace ℝ (Fin n)) :
    signFlip s (signFlip t x) = signFlip (fun k => s k * t k) x := by
  ext k; simp [signFlip_apply, mul_assoc]

/-- A `±1` sign flip is an involution: applying the same flip twice is the
identity. -/
theorem signFlip_involutive {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    signFlip s (signFlip s x) = x := by
  ext k; cases hs k <;> simp [*]

/-- **Headline.** The diagonal `{±1}ⁿ` sign group is *exactly* the Born fiber
over `bornMap x`: `bornMap y = bornMap x` holds iff `y = signFlip s x` for some
`±1` sign vector `s`.  Combined with Wave 145's `bornMap_signFlip` (the ⇐
direction), this pins down the entire gauge redundancy of the wave-function
parametrization as precisely the coordinate-wise sign freedom. -/
theorem bornMap_eq_iff_signFlip (x y : EuclideanSpace ℝ (Fin n)) :
    bornMap y = bornMap x ↔
      ∃ s : Fin n → ℝ, (∀ k, s k = 1 ∨ s k = -1) ∧ y = signFlip s x := by
  constructor
  · intro h_eq
    have h_sq : ∀ k, (y k) ^ 2 = (x k) ^ 2 := fun k => congr_fun h_eq k
    have h_sign : ∀ k, y k = x k ∨ y k = -x k :=
      fun k => eq_or_eq_neg_of_sq_eq_sq _ _ (h_sq k)
    refine ⟨fun k => if y k = x k then 1 else -1, fun k => ?_, ?_⟩
    · dsimp only; split_ifs <;> norm_num
    · ext k; cases h_sign k <;> simp [*]
  · rintro ⟨s, hs, rfl⟩
    exact bornMap_signFlip hs x

end BookProof.ChapterFreeFieldBornSignFiber
