-- Generated from ChapterAttentionRetrieval.lean — theorem BookProof.ChapterAttentionRetrieval.card_erase_cast
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionRetrieval
open BookProof.ChapterAttentionRetrieval

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionRetrieval.card_erase_cast (j : Fin m) :
    ((Finset.univ.erase j).card : ℝ) = (m : ℝ) - 1 := by sorry
