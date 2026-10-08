-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.spectrum_compress_subset_numRange
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
import Mathlib
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterH9


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


theorem BookProof.ChapterH9.spectrum_compress_subset_numRange [FiniteDimensional ℂ F] (V : F →L[ℂ] E)
    (X : E →L[ℂ] E) (hViso : ∀ x : F, ‖V x‖ = ‖x‖) :
    spectrum ℂ ((compress V X : F →ₗ[ℂ] F)) ⊆ numRange X := by sorry
