-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.attentionEntropy_antitoneOn
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
open BookProof.ChapterEntropyTemperature


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}


theorem BookProof.ChapterEntropyTemperature.attentionEntropy_antitoneOn (s : Fin m → ℝ) (i : Fin m) :
    AntitoneOn (fun b : ℝ => attentionEntropy b s) (Set.Ici (0 : ℝ)) := by sorry
