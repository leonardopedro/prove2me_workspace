-- Generated from ChapterAttentionEntropy.lean — theorem BookProof.ChapterAttentionEntropy.tendsto_shannonEntropy_scoreSoftmax
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionEntropy.tendsto_shannonEntropy_scoreSoftmax (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => shannonEntropy (fun l => scoreSoftmax b s l)) atTop (𝓝 0) := by sorry
