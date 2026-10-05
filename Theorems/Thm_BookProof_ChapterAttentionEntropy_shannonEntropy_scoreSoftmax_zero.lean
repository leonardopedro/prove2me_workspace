-- Generated from ChapterAttentionEntropy.lean — theorem BookProof.ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_zero
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionEntropy

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_zero (s : Fin m → ℝ) (hm : 0 < m) :
    shannonEntropy (fun j => scoreSoftmax 0 s j) = Real.log m := by sorry
