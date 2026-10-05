-- Generated from ChapterAttentionLocality.lean — theorem BookProof.ChapterAttentionLocality.norm_headOutput_window_sub_le
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionLocality
import Definitions.Def_ChapterObservableExpectation
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterObservableExpectation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionLocality

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionLocality.norm_headOutput_window_sub_le {beta gamma Delta R : ℝ} (hb : 0 ≤ beta)
    (hg : 0 ≤ gamma) (s : Fin m → ℝ) (d : Fin m → ℝ) {j₀ : Fin m} (hd0 : d j₀ = 0)
    (hR : 0 < R) (hDelta : ∀ l, s l ≤ s j₀ + Delta) {v : Fin m → E} {C : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (hC : 0 ≤ C) :
    ‖observableExpectation
        (maskedSoftmax beta (alibiScore s gamma d) (window d R)) v
      - headOutput beta (alibiScore s gamma d) v‖
      ≤ 2 * ((m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R))))) * C := by sorry
