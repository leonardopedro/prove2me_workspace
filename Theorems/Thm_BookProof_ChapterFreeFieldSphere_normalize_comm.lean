-- Generated from ChapterFreeFieldSphere.lean — theorem BookProof.ChapterFreeFieldSphere.normalize_comm
import Definitions.Def_ChapterFreeFieldGaussian
import Mathlib
import Definitions.Def_ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphere


open MeasureTheory
open BookProof.ChapterFreeFieldGaussian


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldSphere.normalize_comm (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n))
    (x : EuclideanSpace ℝ (Fin n)) : normalize (L x) = L (normalize x) := by sorry
