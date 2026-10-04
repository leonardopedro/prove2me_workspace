-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.push_nonneg
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMarkov.push_nonneg {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : ∀ j, 0 ≤ p j) (j : Fin m) : 0 ≤ push P p j := by sorry
