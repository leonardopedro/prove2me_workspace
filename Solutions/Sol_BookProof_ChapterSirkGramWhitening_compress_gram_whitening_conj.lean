-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.compress_gram_whitening_conj
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_whitened_adjoint_comp_self
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_range_whitened
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E) (X : E →L[ℂ] E)
    {T₁ T₂ : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m)}
    (hT₂ : IsWhitening w T₂) (hs₁ : Function.Surjective T₁) (hs₂ : Function.Surjective T₂) :
    compress (whitened w T₁) X
      = (whiteningEquiv (whitened w T₂) (whitened w T₁)).comp
        ((compress (whitened w T₂) X).comp
          (whiteningEquiv (whitened w T₁) (whitened w T₂))) := by

  have hr₁ := range_whitened w hs₁
  have hr₂ := range_whitened w hs₂
  refine compress_conj_whitening _ _ X (whitened_adjoint_comp_self w hT₂) ?_
  intro y
  have hmem : whitened w T₁ y ∈ LinearMap.range (whitened w T₂ :
      EuclideanSpace ℂ (Fin m) →ₗ[ℂ] E) := by
    rw [hr₂, ← hr₁]; exact ⟨y, rfl⟩
  obtain ⟨z, hz⟩ := hmem
  exact ⟨z, hz.symm⟩
