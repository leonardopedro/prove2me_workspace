-- Generated from ChapterAttentionMixing.lean — solution of BookProof.ChapterAttentionMixing.tendsto_l1dist_pushIter_attentionMatrix
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Theorems.Thm_BookProof_ChapterAttentionMixing_tendsto_l1dist_pushIter
import Theorems.Thm_BookProof_ChapterAttentionMarkov_attentionMatrix_isStochastic
open BookProof.ChapterAttentionMixing



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta D : ℝ} (hb : 0 ≤ beta)
    {S : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} (hp : IsProb p) (hq : IsProb q)
    (hD : ∀ i j l, S i l ≤ S i j + D) (i : Fin m) :
    Tendsto (fun n => l1dist (pushIter (attentionMatrix beta S) n p)
      (pushIter (attentionMatrix beta S) n q)) atTop (𝓝 0) := by

  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast i.pos
  have hmin : ∀ a b, Real.exp (-(beta * D)) / (m : ℝ) ≤ attentionMatrix beta S a b := by
    intro a b
    exact scoreSoftmax_ge_of_spread hb (S a) b (fun l => hD a b l)
  exact tendsto_l1dist_pushIter (attentionMatrix_isStochastic beta S) hmin hp hq
    (by positivity) i
