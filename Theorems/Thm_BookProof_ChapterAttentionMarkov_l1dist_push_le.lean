-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.l1dist_push_le
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMarkov.l1dist_push_le {P : Fin m → Fin m → ℝ} (hP : IsStochastic P) (p q : Fin m → ℝ) :
    l1dist (push P p) (push P q) ≤ l1dist p q := by sorry
