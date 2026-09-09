-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.numRange_compress_subset
import Mathlib
import Definitions.Def_ChapterH9
open BookProof.ChapterH9 BookProof.ChapterH4

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem BookProof.ChapterH9.numRange_compress_subset (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) : numRange (compress V X) ⊆ numRange X := by sorry