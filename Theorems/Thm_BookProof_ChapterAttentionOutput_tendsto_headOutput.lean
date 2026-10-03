-- Generated from ChapterAttentionOutput.lean — theorem BookProof.ChapterAttentionOutput.tendsto_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionOutput.tendsto_headOutput (s : Fin m → ℝ) (v : Fin m → E) (j : Fin m)
    (hmax : ∀ l, l ≠ j → s l < s j) :
    Tendsto (fun b : ℝ => headOutput b s v) atTop (𝓝 (v j)) := by sorry
