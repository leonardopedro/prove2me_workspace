-- Generated from ChapterSirkGramWhitening.lean — theorem BookProof.ChapterSirkGramWhitening.compress_gram_whitening_conj
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterSirkWhitening
open BookProof.ChapterH4
open BookProof.ChapterSirkWhitening
open BookProof.ChapterSirkGramWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening


hmem
    exact ⟨y, hy.symm⟩

theorem BookProof.ChapterSirkGramWhitening.compress_gram_whitening_conj {m : ℕ} (w : Fin m → E) (X : E →L[ℂ] E)
    {T₁ T₂ : EuclideanSpace ℂ (Fin m) →L[ℂ] EuclideanSpace ℂ (Fin m)}
    (hT₂ : IsWhitening w T₂) (hs₁ : Function.Surjective T₁) (hs₂ : Function.Surjective T₂) :
    compress (whitened w T₁) X
      = (whiteningEquiv (whitened w T₂) (whitened w T₁)).comp
        ((compress (whitened w T₂) X).comp
          (whiteningEquiv (whit := by sorry
