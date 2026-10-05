-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.sinkWeight_eq
import Definitions.Def_ChapterObservableExpectation
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSink

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterAttentionSink.sinkWeight_eq (beta s0 : ℝ) (s : Fin m → ℝ) :
    sinkWeight beta s0 s
      = Real.exp (beta * s0) / (Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l)) := by sorry
