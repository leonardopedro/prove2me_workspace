-- Generated from ChapterAttentionRetrieval.lean — theorem BookProof.ChapterAttentionRetrieval.norm_headOutput_sub_le_of_margin
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionRetrieval
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionRetrieval


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionOutput

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionRetrieval.norm_headOutput_sub_le_of_margin {beta delta C : ℝ} (hb : 0 ≤ beta)
    (s : Fin m → ℝ) (v : Fin m → E) (j : Fin m)
    (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) (hv : ∀ l, ‖v l‖ ≤ C) :
    ‖headOutput beta s v - v j‖ ≤ 2 * C * (((m : ℝ) - 1) * Real.exp (-(beta * delta))) := by sorry
