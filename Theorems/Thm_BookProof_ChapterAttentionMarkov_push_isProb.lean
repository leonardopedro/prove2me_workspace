-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.push_isProb
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMarkov.push_isProb {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : IsProb p) : IsProb (push P p) := by sorry
