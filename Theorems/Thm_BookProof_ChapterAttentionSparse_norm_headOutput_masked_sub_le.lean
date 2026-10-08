-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.norm_headOutput_masked_sub_le
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterAttentionOutput
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSparse


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterAttentionMasking
open BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionSparse.norm_headOutput_masked_sub_le (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) (i : Fin m) {v : Fin m → E} {C : ℝ} (hv : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation (maskedSoftmax beta s S) v - headOutput beta s v‖
      ≤ 2 * (1 - attendedMass beta s S) * C := by sorry
