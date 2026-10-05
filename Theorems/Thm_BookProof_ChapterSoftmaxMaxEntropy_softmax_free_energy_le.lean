-- Generated from ChapterSoftmaxMaxEntropy.lean — theorem BookProof.ChapterSoftmaxMaxEntropy.softmax_free_energy_le
import Definitions.Def_ChapterAttentionEntropy
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxMaxEntropy.softmax_free_energy_le (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hpsum : ∑ j, p j = 1) :
    -logPartition beta s ≤ -(beta * ∑ j, p j * s j) - shannonEntropy p := by sorry
