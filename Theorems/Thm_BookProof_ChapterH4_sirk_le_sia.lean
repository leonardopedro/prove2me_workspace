-- Generated from ChapterH4.lean — theorem BookProof.ChapterH4.sirk_le_sia
import Mathlib
import Definitions.Def_ChapterH4
open BookProof.ChapterH4









open scoped BigOperators


noncomputable section





variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterH4.sirk_le_sia (C Dmin h m normv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ normv)
    (hh : 0 ≤ h) (hm : 0 ≤ m) :
    2 * C * Real.exp (-(h * m)) * Dmin * normv ≤ 2 * C * Dmin * normv := by sorry
