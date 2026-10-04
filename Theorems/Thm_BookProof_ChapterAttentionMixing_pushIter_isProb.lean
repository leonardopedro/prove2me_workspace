-- Generated from ChapterAttentionMixing.lean — theorem BookProof.ChapterAttentionMixing.pushIter_isProb
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMixing
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterA4
open BookProof.ChapterDutchBook
open BookProof.ChapterAttentionMixing

variable {m : ℕ}


open scoped BigOperators

open Filter Topology

noncomputable section




theorem BookProof.ChapterAttentionMixing.pushIter_isProb {P : Fin m → Fin m → ℝ} {p : Fin m → ℝ} (hP : IsStochastic P)
    (hp : IsProb p) (n : ℕ) : IsProb (pushIter P n p) := by sorry
