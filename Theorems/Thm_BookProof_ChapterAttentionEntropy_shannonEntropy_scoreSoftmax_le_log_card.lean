-- Generated from ChapterAttentionEntropy.lean — theorem BookProof.ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_le_log_card
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionEntropy


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}


theorem BookProof.ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_le_log_card (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (fun j => scoreSoftmax beta s j) ≤ Real.log m := by sorry
