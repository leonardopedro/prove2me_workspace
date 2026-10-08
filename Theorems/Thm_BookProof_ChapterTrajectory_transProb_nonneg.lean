-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.transProb_nonneg
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory


open scoped BigOperators Matrix


variable {n : ℕ}


theorem BookProof.ChapterTrajectory.transProb_nonneg (V : Matrix (Fin n) (Fin n) ℂ) (f a : Fin n) :
    0 ≤ transProb V f a := by sorry
