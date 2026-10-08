-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.sink_denom_pos
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionSink
open BookProof.ChapterAttentionSink


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionSink.sink_denom_pos (beta s0 : ℝ) (s : Fin m → ℝ) :
    0 < Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l) := by sorry
