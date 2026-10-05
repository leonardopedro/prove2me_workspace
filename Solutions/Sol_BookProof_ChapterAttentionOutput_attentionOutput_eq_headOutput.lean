-- Generated from ChapterAttentionOutput.lean — solution of BookProof.ChapterAttentionOutput.attentionOutput_eq_headOutput
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Theorems.Thm_BookProof_ChapterAttentionOutput_headOutput_eq_sum
open BookProof.ChapterAttentionOutput



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (v : Fin m → E) (r : ℝ)
    (hnorm : ∀ l, ‖k l‖ = r) :
    attentionOutput q k v = headOutput 2 (fun l => (inner ℝ q (k l) : ℝ)) v := by

  rw [attentionOutput, headOutput_eq_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [coherentBorn_eq_softmax q k r hnorm j, softmax_eq_scoreSoftmax]
