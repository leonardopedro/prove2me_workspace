-- Generated from ChapterFreeFieldBornSignGauge.lean — theorem BookProof.ChapterFreeFieldBornSignGauge.bornMap_signFlip
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSignGauge

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn



theorem BookProof.ChapterFreeFieldBornSignGauge.bornMap_signFlip {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    bornMap (signFlip s x) = bornMap x := by sorry
