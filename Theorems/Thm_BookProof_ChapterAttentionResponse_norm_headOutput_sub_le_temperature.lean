-- Generated from ChapterAttentionResponse.lean — theorem BookProof.ChapterAttentionResponse.norm_headOutput_sub_le_temperature
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionResponse
open BookProof.ChapterAttentionResponse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionResponse.norm_headOutput_sub_le_temperature {s : Fin m → ℝ} {v : Fin m → E} {C a b : ℝ}
    (hv : ∀ j, ‖v j‖ ≤ C) (ha : ∀ l, a ≤ s l) (hb : ∀ l, s l ≤ b) (i : Fin m)
    (beta gamma : ℝ) :
    ‖headOutput gamma s v - headOutput beta s v‖ ≤ C * (b - a) * |gamma - beta| := by
  have hderiv : ∀ x ∈ (Set.univ : Set ℝ),
      HasDerivWithinAt (fun t : ℝ => headOutput t s v) (scoreValueCovariance x s v)
        Set.univ x := by sorry
