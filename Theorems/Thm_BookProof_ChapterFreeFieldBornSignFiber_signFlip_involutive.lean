-- Generated from ChapterFreeFieldBornSignFiber.lean — theorem BookProof.ChapterFreeFieldBornSignFiber.signFlip_involutive
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignFiber
open BookProof.ChapterFreeFieldBornSignFiber

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSignGauge



theorem BookProof.ChapterFreeFieldBornSignFiber.signFlip_involutive {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    signFlip s (signFlip s x) = x := by sorry
