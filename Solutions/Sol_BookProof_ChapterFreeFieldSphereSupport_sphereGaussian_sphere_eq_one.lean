-- Generated from ChapterFreeFieldSphereSupport.lean — solution of BookProof.ChapterFreeFieldSphereSupport.sphereGaussian_sphere_eq_one
import Mathlib
import Definitions.Def_ChapterFreeFieldSphereSupport
import Theorems.Thm_BookProof_ChapterFreeFieldSphereSupport_stdGaussian_singleton
open BookProof.ChapterFreeFieldSphereSupport



open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hn : 0 < n) :
    sphereGaussian n (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) = 1 := by

  rw [ sphereGaussian, Measure.map_apply ];
  · rw [ show ChapterFreeFieldSphere.normalize ⁻¹' Metric.sphere 0 1 = { 0 } ᶜ from ?_ ];
    · convert MeasureTheory.measure_compl _ _ <;> norm_num [ stdGaussian_singleton hn ];
    · ext x; simp [ChapterFreeFieldSphere.normalize];
      by_cases hx : x = 0 <;> simp [ hx, norm_smul ];
  · exact ChapterFreeFieldSphere.measurable_normalize
  · exact Metric.isClosed_sphere.measurableSet
