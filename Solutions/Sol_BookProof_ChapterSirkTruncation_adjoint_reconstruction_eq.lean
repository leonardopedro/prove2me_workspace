-- Generated from ChapterSirkTruncation.lean — solution of BookProof.ChapterSirkTruncation.adjoint_reconstruction_eq
import Mathlib
import Definitions.Def_ChapterSirkTruncation
import Definitions.Def_ChapterSirkWhitening
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH4
open BookProof.ChapterSirkTruncation









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterSirkEndToEnd
open BookProof.ChapterSirkWhitening

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (v : E) :
    V.adjoint (V (V.adjoint v)) = V.adjoint v := congrArg (fun f : F →L[ℂ] F => f (V.adjoint v)) hVV
