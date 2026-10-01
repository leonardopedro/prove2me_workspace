-- Generated from ChapterTrajectory.lean — theorem BookProof.ChapterTrajectory.transProb_sum
import Mathlib
import Definitions.Def_ChapterTrajectory
open BookProof.ChapterTrajectory

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterTrajectory.transProb_sum (V : Matrix (Fin n) (Fin n) ℂ) (hV : Vᴴ * V = 1)
    (a : Fin n) : ∑ f, transProb V f a = 1 := by sorry
