-- Generated from ChapterH8.lean — solution of BookProof.ChapterH8.adjoint_compress
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8



noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
open ContinuousLinearMap in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    adjoint (compress V X) = compress V (adjoint X) := by

  rw [compress, compress, adjoint_comp, adjoint_comp, adjoint_adjoint,
    ContinuousLinearMap.comp_assoc]
