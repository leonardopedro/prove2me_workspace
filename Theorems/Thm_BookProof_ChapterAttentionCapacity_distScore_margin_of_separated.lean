-- Generated from ChapterAttentionCapacity.lean — theorem BookProof.ChapterAttentionCapacity.distScore_margin_of_separated
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


theorem BookProof.ChapterAttentionCapacity.distScore_margin_of_separated {k : Fin m → EuclideanSpace ℝ (Fin n)} {r : ℝ}
    (hr : 0 ≤ r) (hsep : keysSeparated k r) (i : Fin m) :
    ∀ l, l ≠ i → distScore (k i) k l + r ^ 2 ≤ distScore (k i) k i := by sorry
