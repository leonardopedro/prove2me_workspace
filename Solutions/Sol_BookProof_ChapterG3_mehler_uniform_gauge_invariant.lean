-- Generated from ChapterG3.lean — solution of BookProof.ChapterG3.mehler_uniform_gauge_invariant
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3



open MeasureTheory
open scoped ENNReal



variable {X : Type*}

variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (PhysHSGaussian.sphereUniform k).map L = PhysHSGaussian.sphereUniform k := PhysHSGaussian.sphereUniform_rotation_invariant k L
