-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.headOutput_mem_convexHull
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionOutput.headOutput_mem_convexHull (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) (i : Fin m) :
    headOutput beta s v ∈ convexHull ℝ (Set.range v) := by sorry
