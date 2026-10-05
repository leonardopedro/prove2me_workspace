-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.headOutput_const
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionOutput

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionOutput.headOutput_const (beta : ℝ) (s : Fin m → ℝ) (w : E) (i : Fin m) :
    headOutput beta s (fun _ => w) = w := by sorry
