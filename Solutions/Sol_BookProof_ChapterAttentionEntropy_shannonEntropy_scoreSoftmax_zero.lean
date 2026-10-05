-- Generated from ChapterAttentionEntropy.lean — solution of BookProof.ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_zero
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Theorems.Thm_BookProof_ChapterAttentionEntropy_shannonEntropy_uniform
open BookProof.ChapterAttentionEntropy



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (hm : 0 < m) :
    shannonEntropy (fun j => scoreSoftmax 0 s j) = Real.log m := by

  have hfun : (fun j : Fin m => scoreSoftmax 0 s j) = fun _ : Fin m => (1 : ℝ) / m :=
    funext fun j => scoreSoftmax_zero s j
  rw [hfun, shannonEntropy_uniform hm]
