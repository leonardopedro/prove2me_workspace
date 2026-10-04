-- Generated from ChapterFreeFieldBornSurj.lean — theorem BookProof.ChapterFreeFieldBornSurj.bornMap_surjOn_stdSimplex
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldBornSurj

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldBornSurj.bornMap_surjOn_stdSimplex :
    Set.SurjOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) := by sorry
