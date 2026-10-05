-- Generated from ChapterFreeFieldBorn.lean — solution of BookProof.ChapterFreeFieldBorn.bornMap_sum_of_mem_sphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBorn



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {x : EuclideanSpace ℝ (Fin n)}
    (hx : x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :
    ∑ k, bornMap x k = 1 := by

  have hnorm : ‖x‖ = 1 := by simpa using hx
  rw [EuclideanSpace.norm_eq x, Real.sqrt_eq_one] at hnorm
  unfold bornMap
  rw [← hnorm]
  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [Real.norm_eq_abs, sq_abs]
