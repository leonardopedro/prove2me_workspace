-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.krylov_rayleigh_transfer
import Mathlib
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH4
open BookProof.ChapterH4
open BookProof.ChapterH6


noncomputable section

open Filter Topology

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterH6.krylov_rayleigh_transfer (V : F →L[ℂ] E) (X : E →L[ℂ] E) (y : F) :
    inner ℂ y (compress V X y) = inner ℂ (V y) (X (V y)) := by sorry
