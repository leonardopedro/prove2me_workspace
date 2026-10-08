-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.adjoint_compress
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open ContinuousLinearMap

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    adjoint (compress V X) = compress V (adjoint X) := by

  rw [compress, compress, adjoint_comp, adjoint_comp, adjoint_adjoint,
    ContinuousLinearMap.comp_assoc]
