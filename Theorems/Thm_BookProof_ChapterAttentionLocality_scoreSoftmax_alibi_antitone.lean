-- Generated from ChapterAttentionLocality.lean — theorem BookProof.ChapterAttentionLocality.scoreSoftmax_alibi_antitone
import Mathlib
import Definitions.Def_ChapterAttentionLocality
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionLocality

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionLocality.scoreSoftmax_alibi_antitone {beta gamma : ℝ} (hb : 0 ≤ beta) (hg : 0 ≤ gamma)
    (c : ℝ) (d : Fin m → ℝ) {i j : Fin m} (hij : d i ≤ d j) :
    scoreSoftmax beta (alibiScore (fun _ => c) gamma d) j
      ≤ scoreSoftmax beta (alibiScore (fun _ => c) gamma d) i := by sorry
