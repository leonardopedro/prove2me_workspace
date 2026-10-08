-- Generated from ChapterAttentionLocality.lean — theorem BookProof.ChapterAttentionLocality.farMass_le
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionLocality
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionLocality


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


theorem BookProof.ChapterAttentionLocality.farMass_le {beta gamma Delta R : ℝ} (hb : 0 ≤ beta) (hg : 0 ≤ gamma)
    (s : Fin m → ℝ) (d : Fin m → ℝ) {j₀ : Fin m} (hd0 : d j₀ = 0)
    (hDelta : ∀ l, s l ≤ s j₀ + Delta) :
    ∑ l ∈ (window d R)ᶜ, scoreSoftmax beta (alibiScore s gamma d) l
      ≤ (m : ℝ) * (Real.exp (beta * Delta) * Real.exp (-(beta * (gamma * R)))) := by sorry
