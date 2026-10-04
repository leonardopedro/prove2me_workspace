-- Generated from ChapterFreeFieldBornSurj.lean — theorem BookProof.ChapterFreeFieldBornSurj.bornSection_mem_sphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSurj

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBornSurj.bornSection_mem_sphere {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    bornSection p ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by sorry
