-- Generated from ChapterFreeFieldBorn.lean — theorem BookProof.ChapterFreeFieldBorn.bornMap_sum_of_mem_sphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBorn

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBorn.bornMap_sum_of_mem_sphere {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    ∑ k, bornMap x k = 1 := by sorry
