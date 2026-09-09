-- Generated from ChapterSirkTruncation.lean — solution of BookProof.ChapterSirkTruncation.isometry_comp
import Mathlib
import Definitions.Def_ChapterSirkTruncation
open BookProof.ChapterSirkTruncation









noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterSirkEndToEnd
open BookProof.ChapterSirkWhitening

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
omit [CompleteSpace E] [CompleteSpace F] [CompleteSpace G] in
theorem solution (V : F →L[ℂ] E) (W : G →L[ℂ] F)
    (hV : ∀ x : F, ‖V x‖ = ‖x‖) (hW : ∀ x : G, ‖W x‖ = ‖x‖) (x : G) :
    ‖(V.comp W) x‖ = ‖x‖ := by

  simp [hV, hW]
