-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.scoreSoftmax_sink_odds
import Definitions.Def_ChapterObservableExpectation
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSink

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionSink.scoreSoftmax_sink_odds (beta s0 : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta (Fin.cons s0 s) i.succ * scoreSoftmax beta s j
      = scoreSoftmax beta (Fin.cons s0 s) j.succ * scoreSoftmax beta s i := by sorry
