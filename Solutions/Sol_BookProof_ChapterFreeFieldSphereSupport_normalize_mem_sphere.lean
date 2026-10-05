-- Generated from ChapterFreeFieldSphereSupport.lean — solution of BookProof.ChapterFreeFieldSphereSupport.normalize_mem_sphere
import Mathlib
import Definitions.Def_ChapterFreeFieldSphereSupport
open BookProof.ChapterFreeFieldSphereSupport



open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {x : EuclideanSpace ℝ (Fin n)} (hx : x ≠ 0) :
    normalize x ∈ Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1 := by

  simp [ ChapterFreeFieldSphere.normalize, norm_smul, hx ]
