-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.shannonEntropy_sink
import Definitions.Def_ChapterObservableExpectation
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSink


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionEntropy

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionSink.shannonEntropy_sink (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (scoreSoftmax beta (Fin.cons s0 s))
      = (-sinkWeight beta s0 s * Real.log (sinkWeight beta s0 s)
          - (1 - sinkWeight beta s0 s) * Real.log (1 - sinkWeight beta s0 s))
        + (1 - sinkWeight beta s0 s) * shannonEntropy (scoreSoftmax beta s) := by sorry
