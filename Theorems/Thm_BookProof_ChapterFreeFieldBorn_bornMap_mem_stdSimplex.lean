-- Generated from ChapterFreeFieldBorn.lean — theorem BookProof.ChapterFreeFieldBorn.bornMap_mem_stdSimplex
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBorn

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBorn.bornMap_mem_stdSimplex {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    bornMap x ∈ stdSimplex ℝ (Fin n) := by sorry
