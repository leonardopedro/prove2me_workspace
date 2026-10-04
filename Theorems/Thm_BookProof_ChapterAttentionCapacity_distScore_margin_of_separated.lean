-- Generated from ChapterAttentionCapacity.lean — theorem BookProof.ChapterAttentionCapacity.distScore_margin_of_separated
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionCapacity
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionCapacity

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionCapacity.distScore_margin_of_separated {k : Fin m → EuclideanSpace ℝ (Fin n)} {r : ℝ}
    (hr : 0 ≤ r) (hsep : keysSeparated k r) (i : Fin m) :
    ∀ l, l ≠ i → distScore (k i) k l + r ^ 2 ≤ distScore (k i) k i := by sorry
