-- Generated from ChapterAttentionCapacity.lean — theorem BookProof.ChapterAttentionCapacity.exists_beta_forall_retrieval
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


theorem BookProof.ChapterAttentionCapacity.exists_beta_forall_retrieval {k : Fin m → EuclideanSpace ℝ (Fin n)}
    {v : Fin m → E} {r C eps : ℝ} (hr : 0 < r) (hsep : keysSeparated k r)
    (hv : ∀ l, ‖v l‖ ≤ C) (heps : 0 < eps) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ b, B ≤ b → ∀ i : Fin m,
      ‖headOutput b (distScore (k i) k) v - v i‖ ≤ eps := by sorry
