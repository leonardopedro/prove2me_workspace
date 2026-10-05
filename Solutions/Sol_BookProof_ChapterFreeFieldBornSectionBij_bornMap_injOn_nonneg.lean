-- Generated from ChapterFreeFieldBornSectionBij.lean — solution of BookProof.ChapterFreeFieldBornSectionBij.bornMap_injOn_nonneg
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSectionBij
open BookProof.ChapterFreeFieldBornSectionBij



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Set.InjOn (bornMap : EuclideanSpace ℝ (Fin n) → _) (nonnegOrthant n) := by

  intro x hx y hy h_eq
  ext k
  have hsq : (x k) ^ 2 = (y k) ^ 2 := congr_fun h_eq k
  have := congr_arg Real.sqrt hsq
  rwa [Real.sqrt_sq (hx k), Real.sqrt_sq (hy k)] at this
