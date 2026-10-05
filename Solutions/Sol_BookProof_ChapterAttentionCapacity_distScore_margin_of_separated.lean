-- Generated from ChapterAttentionCapacity.lean — solution of BookProof.ChapterAttentionCapacity.distScore_margin_of_separated
import Mathlib
import Definitions.Def_ChapterAttentionCapacity
open BookProof.ChapterAttentionCapacity



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {k : Fin m → EuclideanSpace ℝ (Fin n)} {r : ℝ}
    (hr : 0 ≤ r) (hsep : keysSeparated k r) (i : Fin m) :
    ∀ l, l ≠ i → distScore (k i) k l + r ^ 2 ≤ distScore (k i) k i := by

  intro l hl
  have hd : r ≤ ‖k i - k l‖ := hsep i l (Ne.symm hl)
  have hsq : r ^ 2 ≤ ‖k i - k l‖ ^ 2 := by nlinarith [norm_nonneg (k i - k l)]
  have hself : distScore (k i) k i = 0 := by
    simp [distScore]
  rw [hself, distScore]
  linarith
