-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.headOutput_const
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionOutput.headOutput_const (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    headOutput beta s (fun _ => w) = w := by sorry
