-- Generated from ChapterAttentionLocality.lean — theorem BookProof.ChapterAttentionLocality.scoreSoftmax_alibi_le
import Mathlib
import Definitions.Def_ChapterAttentionLocality
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionLocality

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionLocality.scoreSoftmax_alibi_le {beta gamma Delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (d : Fin m → ℝ) {j₀ : Fin m} (hd0 : d j₀ = 0) (hDelta : ∀ l, s l ≤ s j₀ + Delta)
    (l : Fin m) :
    scoreSoftmax beta (alibiScore s gamma d) l
      ≤ Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * d l))) := by sorry
