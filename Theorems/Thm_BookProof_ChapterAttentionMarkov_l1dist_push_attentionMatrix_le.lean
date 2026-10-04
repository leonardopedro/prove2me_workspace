-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.l1dist_push_attentionMatrix_le
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterA4
open BookProof.ChapterDutchBook
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMarkov.l1dist_push_attentionMatrix_le {beta D : ℝ} (hb : 0 ≤ beta)
    {S : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} (hp : IsProb p) (hq : IsProb q)
    (hD : ∀ i j l, S i l ≤ S i j + D) :
    l1dist (push (attentionMatrix beta S) p) (push (attentionMatrix beta S) q)
      ≤ (1 - Real.exp (-(beta * D))) * l1dist p q := by sorry
