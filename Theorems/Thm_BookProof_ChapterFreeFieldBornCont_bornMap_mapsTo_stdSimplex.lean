-- Generated from ChapterFreeFieldBornCont.lean — theorem BookProof.ChapterFreeFieldBornCont.bornMap_mapsTo_stdSimplex
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
open BookProof.ChapterFreeFieldBornCont

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj



theorem BookProof.ChapterFreeFieldBornCont.bornMap_mapsTo_stdSimplex :
    Set.MapsTo (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ))
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) := by sorry
