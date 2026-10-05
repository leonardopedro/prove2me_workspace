-- Generated from ChapterFreeFieldBornSignGauge.lean — theorem BookProof.ChapterFreeFieldBornSignGauge.signFlip_mem_sphere
import Definitions.Def_ChapterFreeFieldBorn
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignGauge

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn



theorem BookProof.ChapterFreeFieldBornSignGauge.signFlip_mem_sphere {s : Fin n → ℝ} (hs : ∀ k, s k = 1 ∨ s k = -1)
    {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    signFlip s x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by sorry
