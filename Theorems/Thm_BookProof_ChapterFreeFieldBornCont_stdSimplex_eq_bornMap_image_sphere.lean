-- Generated from ChapterFreeFieldBornCont.lean — theorem BookProof.ChapterFreeFieldBornCont.stdSimplex_eq_bornMap_image_sphere
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSurj
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
open BookProof.ChapterFreeFieldBornCont

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj



theorem BookProof.ChapterFreeFieldBornCont.stdSimplex_eq_bornMap_image_sphere :
    stdSimplex ℝ (Fin n) =
      (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ)) ''
        (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) := by sorry
