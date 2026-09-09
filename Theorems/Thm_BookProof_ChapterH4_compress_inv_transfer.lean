-- Generated from ChapterH4.lean — theorem BookProof.ChapterH4.compress_inv_transfer
import Mathlib
import Definitions.Def_ChapterH4
open BookProof.ChapterH4









open scoped BigOperators


noncomputable section





variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

omit [CompleteSpace E] [CompleteSpace F] in
theorem BookProof.ChapterH4.compress_inv_transfer (V : F →L[ℂ] E)
    (qX qXinv : E →L[ℂ] E) (qB qBinv : F →L[ℂ] F)
    (hintertwine : qX.comp V = V.comp qB)
    (hqXl : qXinv.comp qX = ContinuousLinearMap.id ℂ E)
    (hqBr : qB.comp qBinv = ContinuousLinearMap.id ℂ F) :
    qXinv.comp V = V.comp qBinv := by sorry
