-- Generated from ChapterAttentionCapacity.lean — theorem BookProof.ChapterAttentionCapacity.norm_headOutput_distScore_sub_le_of_separated
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCapacity
open BookProof.ChapterAttentionCapacity

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCapacity.norm_headOutput_distScore_sub_le_of_separated
    {k : Fin m → EuclideanSpace ℝ (Fin n)} {v : Fin m → E} {r beta C : ℝ}
    (hb : 0 ≤ beta) (hr : 0 ≤ r) (hsep : keysSeparated k r) (hv : ∀ l, ‖v l‖ ≤ C)
    (i : Fin m) :
    ‖headOutput beta (distScore (k i) k) v - v i‖
      ≤ 2 * C * (((m : ℝ) - 1) * Real.exp (-(beta * r ^ 2))) := by sorry
