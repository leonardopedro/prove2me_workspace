-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.headOutput_sink
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


theorem BookProof.ChapterAttentionSink.headOutput_sink (beta s0 : ℝ) (s : Fin m → ℝ) (v0 : E) (v : Fin m → E) :
    headOutput beta (Fin.cons s0 s) (Fin.cons v0 v)
      = sinkWeight beta s0 s • v0 + (1 - sinkWeight beta s0 s) • headOutput beta s v := by sorry
