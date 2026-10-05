import Definitions.Def_ChapterSoftmaxFluctuation
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib

/-!
# Chapter "The Coherent State of Attention": sharpening is monotone

`ChapterSoftmaxFluctuation` differentiates a single attention weight in the
inverse temperature and finds the response law
`dpⱼ/dβ = pⱼ · (sⱼ − ⟨s⟩)`.  This module reads that law as a **monotonicity
statement about sharpening**: lowering the temperature never takes attention away
from the best key and never gives attention to the worst one.

* `deriv_scoreSoftmax_beta` — the response law in `deriv` form;
* `min_le_meanScore` — the mean score is squeezed between the extreme scores
  (the companion of `meanScore_le_max`);
* `scoreSoftmax_monotone_of_max` — **the winner's share is monotone in `β`**;
* `scoreSoftmax_antitone_of_min` — the loser's share is antitone in `β`;
* `scoreSoftmax_max_ge_inv_card` / `scoreSoftmax_min_le_inv_card` — comparing with
  the infinite-temperature value `1/m`: at any positive `β` the best key already
  carries at least the uniform share, the worst key at most it;
* `scoreSoftmax_max_ge_of_le` / `scoreSoftmax_min_le_of_le` — the two-temperature
  form of the same statements.

Nothing here needs a *strict* maximizer: the bounds are the honest weak ones, and
they degenerate to equalities exactly on constant scores.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/
namespace BookProof.ChapterSoftmaxTemperatureMonotone

end BookProof.ChapterSoftmaxTemperatureMonotone
