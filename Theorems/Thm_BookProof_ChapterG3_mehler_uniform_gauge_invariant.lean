-- Generated from ChapterG3.lean — theorem BookProof.ChapterG3.mehler_uniform_gauge_invariant
import Mathlib
import Definitions.Def_ChapterG3
open BookProof.ChapterG3

variable {X : Type*}


open MeasureTheory
open scoped ENNReal




theorem BookProof.ChapterG3.mehler_uniform_gauge_invariant (k : ℕ)
    (L : EuclideanSpace ℝ (Fin k) ≃ₗᵢ[ℝ] EuclideanSpace ℝ (Fin k)) :
    (PhysHSGaussian.sphereUniform k).map L = PhysHSGaussian.sphereUniform k := by sorry
