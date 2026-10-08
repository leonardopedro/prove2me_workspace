-- Generated from ChapterFreeFieldSphereSupport.lean — theorem BookProof.ChapterFreeFieldSphereSupport.stdGaussian_singleton
import Definitions.Def_ChapterFreeFieldGaussian
import Definitions.Def_ChapterFreeFieldSphere
import Mathlib
import Definitions.Def_ChapterFreeFieldSphereSupport
open BookProof.ChapterFreeFieldSphereSupport


open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldSphereSupport.stdGaussian_singleton (hn : 0 < n) (x : EuclideanSpace ℝ (Fin n)) :
    stdGaussian n {x} = 0 := by sorry
