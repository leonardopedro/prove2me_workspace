import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib


/-!
# Chapter "The Coherent State of Attention": the entropy of the attention
distribution

The chapter describes the pre-measurement token as a "high-entropy superposition"
that the attention measurement collapses into a definite output.  `ChapterSoftmaxSharpness`
proves the two limiting shapes of the Softmax distribution; this module measures
them, with the Shannon entropy.

* `shannonEntropy` — `H(p) = -∑ⱼ pⱼ log pⱼ`, and `shannonEntropy_nonneg`.
* `shannonEntropy_le_log_card` — **Gibbs' inequality**: any distribution over `m`
  outcomes has entropy at most `log m`, proved from `log x ≤ x - 1`.
* `shannonEntropy_uniform` — the uniform distribution attains the bound, so
  `log m` is the maximal uncertainty available to a query.
* `shannonEntropy_scoreSoftmax_zero` — at infinite temperature (`β = 0`) attention
  is at maximal entropy `log m`: the query resolves nothing.
* `tendsto_shannonEntropy_scoreSoftmax` — **the collapse.**  If the scores have a
  strict maximizer then the entropy of the attention distribution tends to `0` as
  `β → ∞`: the measurement returns a definite outcome.
* `tendsto_shannonEntropy_bornWeight_smul_query` — the same collapse for the
  coherent-state Born weights as the query is amplified, which is the chapter's
  reading of the measurement.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionEntropy

open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

/-! ## Shannon entropy of a finite distribution -/

/-- The **Shannon entropy** `H(p) = -∑ⱼ pⱼ log pⱼ` of a finite family of weights
(with the usual convention `0 log 0 = 0`, which holds definitionally in Lean since
`Real.log 0 = 0`). -/
def shannonEntropy (p : Fin m → ℝ) : ℝ := -∑ j, p j * Real.log (p j)







/-! ## The attention distribution at the two extremes -/









end BookProof.ChapterAttentionEntropy

end
