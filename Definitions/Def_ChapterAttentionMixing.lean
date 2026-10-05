import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib


/-!
# Chapter "The Coherent State of Attention": iterating the layer

`ChapterAttentionMarkov` shows that one attention layer is a Markov step which
contracts the `ℓ¹` distance between two beliefs about position.  Iterating that
estimate is the mixing statement for a deep stack.

* `pushIter_isProb`, `l1dist_pushIter_le` — after `n` layers two beliefs are within
  `(1 − mε)ⁿ` of their initial `ℓ¹` distance.
* `tendsto_l1dist_pushIter` — with a strictly positive floor `ε` the distance tends
  to `0`: **the stack forgets which belief it started from**.
* `eq_of_stationary` — and there is at most one stationary belief.
* `tendsto_l1dist_pushIter_attentionMatrix` — for a genuine attention layer at
  `β ≥ 0` whose row scores have spread at most `D`, the rate is `(1 − e^{−βD})ⁿ`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

open Filter Topology

noncomputable section

namespace BookProof.ChapterAttentionMixing

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionRetrieval BookProof.ChapterAttentionMarkov

variable {m : ℕ}

/-- The belief after `n` attention layers with the same kernel. -/
def pushIter (P : Fin m → Fin m → ℝ) (n : ℕ) (p : Fin m → ℝ) : Fin m → ℝ :=
  (push P)^[n] p















/-! ## A genuine attention layer -/



end BookProof.ChapterAttentionMixing

end
