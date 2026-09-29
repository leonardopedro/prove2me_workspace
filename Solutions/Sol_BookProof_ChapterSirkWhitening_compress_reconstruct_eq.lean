-- Generated from ChapterSirkWhitening.lean — solution of BookProof.ChapterSirkWhitening.compress_reconstruct_eq
import Mathlib
import Definitions.Def_ChapterSirkWhitening
import Definitions.Def_ChapterH4
open BookProof.ChapterSirkWhitening








noncomputable section


open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    V.comp ((compress V X).comp V.adjoint) = (rangeProj V).comp (X.comp (rangeProj V)) := by

  ext u
  simp [compress, rangeProj]
