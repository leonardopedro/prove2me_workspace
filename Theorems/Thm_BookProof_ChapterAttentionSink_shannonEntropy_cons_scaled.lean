-- Generated from ChapterAttentionSink.lean — theorem BookProof.ChapterAttentionSink.shannonEntropy_cons_scaled
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionSink
import Definitions.Def_ChapterAttentionEntropy
open BookProof.ChapterAttentionSink


open scoped BigOperators

noncomputable section


open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionEntropy

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionSink.shannonEntropy_cons_scaled {w : ℝ} (hw1 : w < 1) {p : Fin m → ℝ}
    (hp : ∀ j, 0 < p j) (hsum : ∑ j, p j = 1) :
    shannonEntropy (Fin.cons w (fun j => (1 - w) * p j) : Fin (m + 1) → ℝ)
      = (-w * Real.log w - (1 - w) * Real.log (1 - w)) + (1 - w) * shannonEntropy p := by sorry
