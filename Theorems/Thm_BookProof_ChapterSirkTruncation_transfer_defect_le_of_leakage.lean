-- Generated from ChapterSirkTruncation.lean — theorem BookProof.ChapterSirkTruncation.transfer_defect_le_of_leakage
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

theorem BookProof.ChapterSirkTruncation.transfer_defect_le_of_leakage (V : F →L[ℂ] E) (rX : E →L[ℂ] E) (rB : F →L[ℂ] F)
    (v : E) (hexact : rX (V (V.adjoint v)) = V (rB (V.adjoint (V (V.adjoint v)))))
    (hproj : V.adjoint (V (V.adjoint v)) = V.adjoint v) :
    ‖rX v - V (rB (V.adjoint v))‖ ≤ ‖rX‖ * ‖v - V (V.adjoint v)‖ := by sorry
