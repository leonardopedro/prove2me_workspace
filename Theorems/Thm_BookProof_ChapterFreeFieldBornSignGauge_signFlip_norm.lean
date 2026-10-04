-- Generated from ChapterFreeFieldBornSignGauge.lean — theorem BookProof.ChapterFreeFieldBornSignGauge.signFlip_norm
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSignGauge

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn



theorem BookProof.ChapterFreeFieldBornSignGauge.signFlip_norm {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    (x : EuclideanSpace ℝ (Fin n)) :
    ‖signFlip s x‖ = ‖x‖ := by sorry
