-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.headOutput_eq_sum
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionOutput.headOutput_eq_sum (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    headOutput beta s v = ∑ j, scoreSoftmax beta s j • v j := by sorry
