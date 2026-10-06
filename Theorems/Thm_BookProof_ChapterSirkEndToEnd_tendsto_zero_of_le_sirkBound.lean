-- Generated from ChapterSirkEndToEnd.lean — theorem BookProof.ChapterSirkEndToEnd.tendsto_zero_of_le_sirkBound
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH8
import Definitions.Def_ChapterH9
import Mathlib
import Definitions.Def_ChapterSirkEndToEnd
import Definitions.Def_ChapterH6
open BookProof.ChapterH6
open BookProof.ChapterSirkEndToEnd

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]


noncomputable section

open Filter Topology


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH8 BookProof.ChapterH9


theorem BookProof.ChapterSirkEndToEnd.tendsto_zero_of_le_sirkBound (err : ℕ → ℝ) (C Dmin h nv : ℝ) (hh : 0 < h)
    (hnn : ∀ m, 0 ≤ err m) (hle : ∀ m, err m ≤ sirkBound C Dmin h nv m) :
    Tendsto err atTop (𝓝 0) := by sorry
