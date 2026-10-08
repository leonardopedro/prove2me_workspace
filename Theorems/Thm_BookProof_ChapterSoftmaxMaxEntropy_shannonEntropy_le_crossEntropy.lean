-- Generated from ChapterSoftmaxMaxEntropy.lean — theorem BookProof.ChapterSoftmaxMaxEntropy.shannonEntropy_le_crossEntropy
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
open BookProof.ChapterSoftmaxMaxEntropy


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}


theorem BookProof.ChapterSoftmaxMaxEntropy.shannonEntropy_le_crossEntropy {p q : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hpsum : ∑ j, p j = 1) (hq0 : ∀ j, 0 < q j) (hqsum : ∑ j, q j ≤ 1) :
    shannonEntropy p ≤ crossEntropy p q := by sorry
