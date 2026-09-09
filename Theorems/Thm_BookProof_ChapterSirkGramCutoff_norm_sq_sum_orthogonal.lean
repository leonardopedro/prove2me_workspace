-- Generated from ChapterSirkGramCutoff.lean — theorem BookProof.ChapterSirkGramCutoff.norm_sq_sum_orthogonal
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
open BookProof.ChapterSirkGramCutoff









noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

theorem BookProof.ChapterSirkGramCutoff.norm_sq_sum_orthogonal {m : ℕ} (y : Fin m → E) (lam : Fin m → ℝ)
    (h : ∀ k l, ⟪y k, y l⟫_ℂ = if k = l then (lam l : ℂ) else 0)
    (s : Finset (Fin m)) (a : Fin m → ℂ) :
    ‖∑ k ∈ s, a k • y k‖ ^ 2 = ∑ k ∈ s, ‖a k‖ ^ 2 * lam k := by sorry
