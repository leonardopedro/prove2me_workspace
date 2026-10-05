-- Generated from ChapterFreeFieldBornSectionBij.lean — solution of BookProof.ChapterFreeFieldBornSectionBij.bornSection_bornMap
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSectionBij
import Theorems.Thm_BookProof_ChapterFreeFieldBornSurj_bornSection_apply
open BookProof.ChapterFreeFieldBornSectionBij



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSurj


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {x : EuclideanSpace ℝ (Fin n)} (hx : x ∈ nonnegOrthant n) :
    bornSection (bornMap x) = x := by

  ext k
  rw [bornSection_apply]
  change Real.sqrt ((x k) ^ 2) = x k
  rw [Real.sqrt_sq (hx k)]
