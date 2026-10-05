-- Generated from ChapterEntropyTemperature.lean — solution of BookProof.ChapterEntropyTemperature.attentionEntropy_le_at_zero
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Theorems.Thm_BookProof_ChapterEntropyTemperature_attentionEntropy_antitoneOn
open BookProof.ChapterEntropyTemperature



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) {beta : ℝ}
    (hbeta : 0 ≤ beta) : attentionEntropy beta s ≤ attentionEntropy 0 s := attentionEntropy_antitoneOn s i (Set.self_mem_Ici) (Set.mem_Ici.2 hbeta) hbeta
