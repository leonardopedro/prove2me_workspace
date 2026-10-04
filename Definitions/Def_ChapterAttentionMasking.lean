import Definitions.Def_ChapterA4
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib


/-!
# Chapter "The Coherent State of Attention" — masking is conditioning

A transformer head almost never attends to all of its keys: a *mask* restricts
the sum to an admissible set `S` of keys (the causal mask `{l ≤ i}` being the
standard example).  This module proves that masking is not an extra ingredient
but the **Bayesian conditioning** of the unmasked attention distribution on the
event "the key lies in `S`".

Deliverables (all `sorry`-free, `axiom`-free):

* `maskedSoftmax β s S` — Softmax restricted to the admissible keys;
* `maskedSoftmax_sum_one`, `maskedSoftmax_nonneg`, `maskedSoftmax_pos_of_mem`,
  `maskedSoftmax_eq_zero_of_not_mem` — it is a probability distribution supported
  exactly on `S`;
* `maskedSoftmax_univ` — the empty mask is ordinary Softmax;
* **`maskedSoftmax_eq_conditional`** — the headline: on `S` the masked weight is
  the unmasked weight renormalized by the total unmasked weight of `S`, i.e.
  `p(j | S) = p(j)/p(S)`;
* `maskedSoftmax_odds` — masking leaves every odds ratio inside `S` untouched: it
  removes keys, it does not re-rank them;
* `maskedSoftmax_le_iff` — and hence preserves the score order on `S`;
* `maskedSoftmax_restrict` — the tower property: conditioning on `T ⊆ S` a
  distribution already conditioned on `S` gives conditioning on `T`, so a
  composite mask is a single mask;
* `causalMask` — the causal (autoregressive) mask, its monotonicity, and
  `causalSoftmax_eq_zero_of_lt`: no weight on the future.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionMasking


variable {m : ℕ}

/-! ## The masked attention distribution -/

/-- **Masked Softmax**: attention restricted to the admissible key set `S`. -/
def maskedSoftmax (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (j : Fin m) : ℝ :=
  if j ∈ S then Real.exp (beta * s j) / ∑ l ∈ S, Real.exp (beta * s l) else 0















/-! ## Masking is Bayesian conditioning -/









/-! ## The causal mask -/

/-- The **causal (autoregressive) mask**: position `i` may attend only to
positions `l ≤ i`. -/
def causalMask (m : ℕ) (i : Fin m) : Finset (Fin m) := Finset.univ.filter fun l => l ≤ i











end BookProof.ChapterAttentionMasking

end
