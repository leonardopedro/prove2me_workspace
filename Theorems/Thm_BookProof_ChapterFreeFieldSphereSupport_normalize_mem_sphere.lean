-- Generated from ChapterFreeFieldSphereSupport.lean — theorem BookProof.ChapterFreeFieldSphereSupport.normalize_mem_sphere
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Mathlib
import Definitions.Def_ChapterFreeFieldSphereSupport
open BookProof.ChapterFreeFieldSphereSupport

variable {n : ℕ}


open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere



theorem BookProof.ChapterFreeFieldSphereSupport.normalize_mem_sphere {x : EuclideanSpace ℝ (Fin n)} (hx : x ≠ 0) :
    normalize x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by sorry
