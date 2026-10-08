-- Generated from ChapterFreeFieldBornSurj.lean — theorem BookProof.ChapterFreeFieldBornSurj.bornSection_mem_sphere
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterFreeFieldSphereSupport
import Definitions.Def_ChapterFreeFieldBorn
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornSurj


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSurj.bornSection_mem_sphere {p : Fin n → ℝ} (hp : p ∈ stdSimplex ℝ (Fin n)) :
    bornSection p ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by sorry
