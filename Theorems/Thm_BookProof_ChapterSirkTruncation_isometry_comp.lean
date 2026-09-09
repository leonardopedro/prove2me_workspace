-- Generated from ChapterSirkTruncation.lean — theorem BookProof.ChapterSirkTruncation.isometry_comp
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

omit [CompleteSpace E] [CompleteSpace F] [CompleteSpace G] in
theorem BookProof.ChapterSirkTruncation.isometry_comp (V : F →L[ℂ] E) (W : G →L[ℂ] F)
    (hV : ∀ x : F, ‖V x‖ = ‖x‖) (hW : ∀ x : G, ‖W x‖ = ‖x‖) (x : G) :
    ‖(V.comp W) x‖ = ‖x‖ := by sorry
