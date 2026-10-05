-- Generated from ChapterAttentionCapacity.lean — solution of BookProof.ChapterAttentionCapacity.scoreSoftmax_distScore_ge_of_separated
import Mathlib
import Definitions.Def_ChapterAttentionCapacity
import Theorems.Thm_BookProof_ChapterAttentionCapacity_distScore_margin_of_separated
open BookProof.ChapterAttentionCapacity



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {k : Fin m → EuclideanSpace ℝ (Fin n)}
    {r beta : ℝ} (hb : 0 ≤ beta) (hr : 0 ≤ r) (hsep : keysSeparated k r) (i : Fin m) :
    1 / (1 + ((m : ℝ) - 1) * Real.exp (-(beta * r ^ 2)))
      ≤ scoreSoftmax beta (distScore (k i) k) i := scoreSoftmax_ge_inv_of_margin hb _ i (distScore_margin_of_separated hr hsep i)
