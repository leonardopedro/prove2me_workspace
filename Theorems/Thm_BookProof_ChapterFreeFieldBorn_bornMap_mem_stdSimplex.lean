-- Generated from ChapterFreeFieldBorn.lean — theorem BookProof.ChapterFreeFieldBorn.bornMap_mem_stdSimplex
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBorn

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport



theorem BookProof.ChapterFreeFieldBorn.bornMap_mem_stdSimplex {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    bornMap x ∈ stdSimplex ℝ (Fin n) := by sorry
