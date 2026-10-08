-- Generated from ChapterFreeFieldBornSignGauge.lean — theorem BookProof.ChapterFreeFieldBornSignGauge.bornMap_signFlip
import Definitions.Def_ChapterFreeFieldBorn
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignGauge


open MeasureTheory
open BookProof.ChapterFreeFieldBorn


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignGauge.bornMap_signFlip {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (signFlip s x) = bornMap x := by sorry
