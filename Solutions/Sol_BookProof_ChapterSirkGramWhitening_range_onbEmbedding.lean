-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.range_onbEmbedding
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} (S : Submodule ℂ E) [CompleteSpace S]
    (b : OrthonormalBasis (Fin d) ℂ S) :
    LinearMap.range (onbEmbedding S b : EuclideanSpace ℂ (Fin d) →ₗ[ℂ] E) = S := by

  ext x
  constructor
  · rintro ⟨c, rfl⟩; exact (b.repr.symm c).2
  · intro hx
    exact ⟨b.repr ⟨x, hx⟩, by simp [onbEmbedding_apply]⟩
