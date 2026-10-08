-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.tendsto_l1dist_pushIter_attentionMatrix
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMixing


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


theorem BookProof.ChapterAttentionMixing.tendsto_l1dist_pushIter_attentionMatrix {beta D : ℝ} (hb : 0 ≤ beta)
    {S : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} (hp : IsProb p) (hq : IsProb q)
    (hD : ∀ i j l, S i l ≤ S i j + D) (i : Fin m) :
    Tendsto (fun n => l1dist (pushIter (attentionMatrix beta S) n p)
      (pushIter (attentionMatrix beta S) n q)) atTop (𝓝 0) := by sorry
