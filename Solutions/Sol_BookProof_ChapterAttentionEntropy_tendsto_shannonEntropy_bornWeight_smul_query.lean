-- Generated from ChapterAttentionEntropy.lean — solution of BookProof.ChapterAttentionEntropy.tendsto_shannonEntropy_bornWeight_smul_query
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Theorems.Thm_BookProof_ChapterAttentionEntropy_tendsto_shannonEntropy_scoreSoftmax
open BookProof.ChapterAttentionEntropy



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ}
    (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ)
    (hk : ∀ l, ‖k l‖ = r) (j : Fin m)
    (hmax : ∀ l, l ≠ j → (inner ℝ q (k l) : ℝ) < inner ℝ q (k j)) :
    Tendsto (fun c : ℝ => shannonEntropy (fun l => bornWeight (c • q) k l)) atTop (𝓝 0) := by

  have hrewrite : ∀ c : ℝ, (fun l => bornWeight (c • q) k l)
      = fun l => scoreSoftmax (2 * c) (fun i => inner ℝ q (k i)) l := by
    intro c
    funext l
    rw [coherentBorn_eq_softmax (c • q) k r hk l, softmax_smul_query, softmax_eq_scoreSoftmax]
  have hscale : Tendsto (fun c : ℝ => 2 * c) atTop atTop :=
    Filter.tendsto_id.const_mul_atTop (by norm_num)
  have hlim := (tendsto_shannonEntropy_scoreSoftmax (fun i => inner ℝ q (k i)) j hmax).comp hscale
  convert hlim using 1 <;> (first | rfl | (funext x; rw [hrewrite x]; rfl))
