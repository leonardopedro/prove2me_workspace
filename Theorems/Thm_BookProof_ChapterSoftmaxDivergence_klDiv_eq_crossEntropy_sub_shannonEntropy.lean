-- Generated from ChapterSoftmaxDivergence.lean — theorem BookProof.ChapterSoftmaxDivergence.klDiv_eq_crossEntropy_sub_shannonEntropy
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
open BookProof.ChapterSoftmaxDivergence

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxDivergence.klDiv_eq_crossEntropy_sub_shannonEntropy {p q : Fin m → ℝ}
    (hq0 : ∀ j, 0 < q j) :
    klDiv p q = crossEntropy p q - shannonEntropy p := by sorry
