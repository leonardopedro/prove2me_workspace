import Mathlib
import BookProof.ChapterFreeFieldBornSignGauge

/-!
# Chapter "Wave-function parametrization of a probability measure", §5 —
# the diagonal sign gauge as an action of the elementary abelian 2-group

Source: `book.tex`, Introduction, section *"Wave-function collapse versus Euler's
formula"* (`book.tex` line ~805) together with the free-field construction of §5
(`book.tex` ~line 1706).

Earlier waves recorded the *combinatorics* of the diagonal `{±1}ⁿ` sign gauge of
the Born map `x ↦ (x_k)²`: each Born fiber is a full orbit of the sign group
restricted to the positive support, `#fiber = 2 ^ (#positive coordinates)`, and
the orbit–stabilizer identity `#orbit · #stabilizer = 2ⁿ`.

This wave records the underlying **group action** itself. Indexing the sign group
by boolean vectors under coordinate-wise `xor` — the elementary abelian
2-group `(Fin n → Bool, ⊕)` — the sign flip `boolFlip b` (flip the sign of the
`k`-th coordinate exactly when `b k = true`) satisfies the action laws:

* the all-`false` vector acts as the identity;
* composition follows the `xor` group law (`boolFlip b₁ ∘ boolFlip b₂ =
  boolFlip (b₁ ⊕ b₂)`);
* every element is an involution;
* each `boolFlip b` preserves the unit sphere and leaves the Born image fixed.

Finally we record when the action is trivial and, in particular, that it is
**free on the strictly positive sphere** (`boolFlip b x = x ↔ b = 0` when every
coordinate of `x` is nonzero) — the group-theoretic reason the generic Born fiber
has the full `2ⁿ` elements.

## Main results

* `boolFlip_pm` — the sign vector of a boolean flip is `±1`.
* `boolFlip_false` — the all-`false` vector acts as the identity.
* `boolFlip_comp` — composition realizes the `xor` group law.
* `boolFlip_involutive` — every flip is an involution.
* `boolFlip_mem_sphere` — the action preserves the unit sphere.
* `bornMap_boolFlip` — the Born image is fixed by the action.
* `boolFlip_eq_self_iff` — `boolFlip b x = x` iff `b` is `false` on every
  nonzero coordinate of `x`.
* **headline** `boolFlip_free_of_pos` — the action is free on the strictly
  positive sphere: `boolFlip b x = x ↔ b = fun _ => false` when every coordinate
  of `x` is nonzero.

Everything is intended to be `sorry`-free and axiom-clean.
-/

open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge

namespace BookProof.ChapterFreeFieldBornSignAction

variable {n : ℕ}

/-- The `±1` sign vector determined by a boolean flip choice: coordinate `k` is
flipped (`-1`) exactly when `b k = true`. With this convention the group law on
boolean vectors is coordinate-wise `xor`. -/
def flipVec (b : Fin n → Bool) : Fin n → ℝ := fun k => if b k then -1 else 1

/-- The sign flip of `x` induced by a boolean flip vector `b`. -/
noncomputable def boolFlip (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    EuclideanSpace ℝ (Fin n) :=
  signFlip (flipVec b) x

@[simp] theorem boolFlip_apply (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) (k : Fin n) :
    boolFlip b x k = (if b k then -1 else 1) * x k := rfl

/-- The sign vector of a boolean flip takes only the values `±1`. -/
theorem flipVec_pm (b : Fin n → Bool) (k : Fin n) :
    flipVec b k = 1 ∨ flipVec b k = -1 := by
  unfold flipVec; split_ifs <;> simp

/-
The all-`false` boolean vector acts as the identity.
-/
theorem boolFlip_false (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip (fun _ => false) x = x := by
  ext k; exact (by
  convert boolFlip_apply ( fun _ => false ) x k using 1 ; norm_num)

/-
**Composition follows the `xor` group law.** Flipping by `b₂` and then by
`b₁` is the single flip by the coordinate-wise `xor` `b₁ ⊕ b₂`; this exhibits
`boolFlip` as an action of the elementary abelian 2-group `(Fin n → Bool, ⊕)`.
-/
theorem boolFlip_comp (b₁ b₂ : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip b₁ (boolFlip b₂ x) = boolFlip (fun k => xor (b₁ k) (b₂ k)) x := by
  ext k; simp [*]
  grind +qlia

/-
Every sign flip is an involution.
-/
theorem boolFlip_involutive (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    boolFlip b (boolFlip b x) = x := by
  grind +suggestions

/-- The action preserves the unit sphere. -/
theorem boolFlip_mem_sphere (b : Fin n → Bool) {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    boolFlip b x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 :=
  signFlip_mem_sphere (flipVec_pm b) hx

/-- The Born image is fixed by the whole diagonal sign action. -/
theorem bornMap_boolFlip (b : Fin n → Bool) (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (boolFlip b x) = bornMap x :=
  bornMap_signFlip (flipVec_pm b) x

/-
`boolFlip b x = x` exactly when `b` is `false` on every nonzero coordinate of
`x` (the flip may act arbitrarily on the vanishing coordinates).
-/
theorem boolFlip_eq_self_iff {b : Fin n → Bool} {x : EuclideanSpace ℝ (Fin n)} :
    boolFlip b x = x ↔ ∀ k, x k ≠ 0 → b k = false := by
  refine ⟨fun h => ?_, fun h => ?_⟩
  · grind +suggestions
  · ext k; by_cases hk : x.ofLp k = 0 <;> simp_all [boolFlip_apply]

/-
**Headline (free action on the strictly positive sphere).** If every
coordinate of `x` is nonzero, the diagonal sign action is free: `boolFlip b x = x`
forces `b` to be the identity `fun _ => false`. This is the group-theoretic
reason the Born fiber over a strictly positive distribution has the full `2ⁿ`
elements.
-/
theorem boolFlip_free_of_pos {b : Fin n → Bool} {x : EuclideanSpace ℝ (Fin n)}
    (hx : ∀ k, x k ≠ 0) :
    boolFlip b x = x ↔ b = (fun _ => false) := by
  rw [boolFlip_eq_self_iff]; aesop

end BookProof.ChapterFreeFieldBornSignAction
