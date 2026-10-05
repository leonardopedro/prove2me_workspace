-- Generated from ChapterFreeFieldSphere.lean — theorem BookProof.ChapterFreeFieldSphere.sphereGaussian_map_linearIsometryEquiv
import Definitions.Def_ChapterFreeFieldGaussian
import Mathlib
import Definitions.Def_ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphere

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian



theorem BookProof.ChapterFreeFieldSphere.sphereGaussian_map_linearIsometryEquiv
    (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n)) :
    (sphereGaussian n).map L = sphereGaussian n := by sorry
