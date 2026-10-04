-- Generated from ChapterFreeFieldSphere.lean — theorem BookProof.ChapterFreeFieldSphere.normalize_comm
import Mathlib
import Definitions.Def_ChapterFreeFieldSphere
import Definitions.Def_ChapterA4
open BookProof.ChapterFreeFieldSphere

variable {n : ℕ}


open MeasureTheory



theorem BookProof.ChapterFreeFieldSphere.normalize_comm (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n))
    (x : EuclideanSpace ℝ (Fin n)) : normalize (L x) = L (normalize x) := by sorry
