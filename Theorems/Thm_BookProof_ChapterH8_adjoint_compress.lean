-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.adjoint_compress
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

open ContinuousLinearMap in
theorem BookProof.ChapterH8.adjoint_compress (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    adjoint (compress V X) = compress V (adjoint X) := by sorry
