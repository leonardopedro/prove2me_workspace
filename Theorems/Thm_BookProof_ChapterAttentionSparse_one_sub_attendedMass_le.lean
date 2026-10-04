-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.one_sub_attendedMass_le
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionSparse.one_sub_attendedMass_le (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m)
    {eps : ℝ} (h : ∀ l ∉ S, scoreSoftmax beta s l ≤ eps) :
    1 - attendedMass beta s S ≤ (m - S.card : ℝ) * eps := by sorry
