-- Generated from ChapterSoftmaxSharpness.lean — theorem BookProof.ChapterSoftmaxSharpness.tendsto_scoreSoftmax_ne
import Definitions.Def_ChapterSoftmaxBorn
import Mathlib
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness


open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}


theorem BookProof.ChapterSoftmaxSharpness.tendsto_scoreSoftmax_ne (s : Fin m → ℝ) (j i : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) (hi : i ≠ j) :
    Tendsto (fun b : ℝ => scoreSoftmax b s i) atTop (𝓝 0) := by sorry
