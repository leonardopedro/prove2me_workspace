-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.numRange_compress_subset
import Mathlib
import Definitions.Def_ChapterH9
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) : numRange (compress V X) ⊆ numRange X := by

  rintro c ⟨y, hy, rfl⟩
  exact ⟨V y, by rw [hViso, hy], (krylov_rayleigh_transfer V X y).symm⟩
