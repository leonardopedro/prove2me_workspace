-- Generated from ChapterFreeFieldGaussian.lean — theorem BookProof.ChapterFreeFieldGaussian.stdGaussian_map_linearIsometryEquiv
import Mathlib
import Definitions.Def_ChapterFreeFieldGaussian
open BookProof.ChapterFreeFieldGaussian


open MeasureTheory ProbabilityTheory Complex WithLp
open scoped RealInnerProductSpace ENNReal


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldGaussian.stdGaussian_map_linearIsometryEquiv
    (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n)) :
    (stdGaussian n).map L = stdGaussian n := by sorry
