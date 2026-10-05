-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.hasDerivAt_attentionEntropy
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
open BookProof.ChapterEntropyTemperature

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterEntropyTemperature.hasDerivAt_attentionEntropy (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => attentionEntropy b s) (-(beta * varScore beta s)) beta := by sorry
