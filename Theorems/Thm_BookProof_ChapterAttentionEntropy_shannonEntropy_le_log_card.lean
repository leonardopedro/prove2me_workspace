-- Generated from ChapterAttentionEntropy.lean — theorem BookProof.ChapterAttentionEntropy.shannonEntropy_le_log_card
import Definitions.Def_ChapterSoftmaxBorn
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterAttentionEntropy

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionEntropy.shannonEntropy_le_log_card {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hsum : ∑ j, p j = 1) : shannonEntropy p ≤ Real.log m := by sorry
