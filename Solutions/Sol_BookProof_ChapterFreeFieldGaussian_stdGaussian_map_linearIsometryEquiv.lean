-- Generated from ChapterFreeFieldGaussian.lean — solution of BookProof.ChapterFreeFieldGaussian.stdGaussian_map_linearIsometryEquiv
import Mathlib
import Definitions.Def_ChapterFreeFieldGaussian
open BookProof.ChapterFreeFieldGaussian



open MeasureTheory ProbabilityTheory Complex WithLp
open scoped RealInnerProductSpace ENNReal


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution
    (L : EuclideanSpace ℝ (Fin n) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin n)) :
    (stdGaussian n).map L = stdGaussian n := by

  unfold stdGaussian
  rw [ProbabilityTheory.map_pi_eq_stdGaussian]
  exact ProbabilityTheory.stdGaussian_map L
