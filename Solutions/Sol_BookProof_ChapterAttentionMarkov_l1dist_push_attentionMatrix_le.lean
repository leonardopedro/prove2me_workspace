-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.l1dist_push_attentionMatrix_le
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Theorems.Thm_BookProof_ChapterAttentionMarkov_attentionMatrix_isStochastic
import Theorems.Thm_BookProof_ChapterAttentionMarkov_l1dist_push_le_of_min
import Theorems.Thm_BookProof_ChapterAttentionRetrieval_scoreSoftmax_ge_of_spread
open BookProof.ChapterAttentionMarkov



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta D : ℝ} (hb : 0 ≤ beta)
    {S : Fin m → Fin m → ℝ} {p q : Fin m → ℝ} (hp : IsProb p) (hq : IsProb q)
    (hD : ∀ i j l, S i l ≤ S i j + D) :
    l1dist (push (attentionMatrix beta S) p) (push (attentionMatrix beta S) q)
      ≤ (1 - Real.exp (-(beta * D))) * l1dist p q := by

  rcases Nat.eq_zero_or_pos m with hm0 | hm0
  · subst hm0
    have := hp.2
    simp at this
  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hm0
  have hmin : ∀ i j, Real.exp (-(beta * D)) / (m : ℝ) ≤ attentionMatrix beta S i j := by
    intro i j
    exact scoreSoftmax_ge_of_spread hb (S i) j (fun l => hD i j l)
  have h := l1dist_push_le_of_min (attentionMatrix_isStochastic beta S) hmin hp hq
  have hfac : (m : ℝ) * (Real.exp (-(beta * D)) / (m : ℝ)) = Real.exp (-(beta * D)) := by
    field_simp
  rwa [hfac] at h
