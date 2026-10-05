-- Generated from ChapterFreeFieldBornCont.lean — solution of BookProof.ChapterFreeFieldBornCont.bornMap_mapsTo_stdSimplex
import Mathlib
import Definitions.Def_ChapterFreeFieldBornCont
import Theorems.Thm_BookProof_ChapterFreeFieldBorn_bornMap_mem_stdSimplex
open BookProof.ChapterFreeFieldBornCont



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Set.MapsTo (bornMap : EuclideanSpace ℝ (Fin n) → (Fin n → ℝ))
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) := fun _ hx => bornMap_mem_stdSimplex hx
