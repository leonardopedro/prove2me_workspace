-- Generated from ChapterFreeFieldSphereSupport.lean — theorem BookProof.ChapterFreeFieldSphereSupport.sphereGaussian_sphere_eq_one
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Mathlib
import Definitions.Def_ChapterFreeFieldSphereSupport
open BookProof.ChapterFreeFieldSphereSupport


open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldSphereSupport.sphereGaussian_sphere_eq_one (hn : 0 < n) :
    sphereGaussian n (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) = 1 := by sorry
