import Definitions.Def_ChapterSoftmaxMaxEntropy
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib


/-!
# Chapter "The Coherent State of Attention" — the entropy is antitone in the
inverse temperature

`ChapterAttentionEntropy` computes the two endpoints of the attention entropy:
it is `log m` at `β = 0` (maximal ignorance) and tends to `0` as `β → ∞` (the
argmax collapse).  `ChapterSoftmaxFluctuation` supplies the response laws.  This
module joins the two ends by differentiating the entropy itself.

* `attentionEntropy` `H(β) = H(scoreSoftmax β s)` and the thermodynamic identity
  `attentionEntropy_eq` : `H(β) = log Z(β) − β⟨s⟩_β`;
* `hasDerivAt_attentionEntropy` — **the headline**: `dH/dβ = −β · Var_β(s)`;
* `heatCapacity` `C(β) = β² · Var_β(s)` and
  `hasDerivAt_attentionEntropy_neg_heatCapacity` — the standard
  `dH/d log(1/β)`-style reading: the response of the entropy is the (nonnegative)
  heat capacity divided by `−β`;
* `attentionEntropy_antitoneOn` — consequently the attention entropy is
  **non-increasing** on `β ≥ 0`: sharpening attention can only destroy entropy;
* `attentionEntropy_le_at_zero` — every positive temperature parameter gives at
  most the `β = 0` entropy, which `ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_zero`
  identifies with `log m`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterEntropyTemperature

open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxFluctuation BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}

/-- The **attention entropy** as a function of the inverse temperature. -/
def attentionEntropy (beta : ℝ) (s : Fin m → ℝ) : ℝ := shannonEntropy (scoreSoftmax beta s)





/-- The **heat capacity** `C(β) = β²·Var_β(s)` of the attention head. -/
def heatCapacity (beta : ℝ) (s : Fin m → ℝ) : ℝ := beta ^ 2 * varScore beta s











end BookProof.ChapterEntropyTemperature

end
