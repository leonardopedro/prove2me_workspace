-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.sinkWeight_lt_one
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionSink
open BookProof.ChapterAttentionSink


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionSink.sinkWeight_lt_one (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    sinkWeight beta s0 s < 1 := by sorry
