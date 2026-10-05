-- Generated from ChapterFreeFieldBornSectionBij.lean — solution of BookProof.ChapterFreeFieldBornSectionBij.bornSection_nonneg
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
theorem solution (p : Fin n → ℝ) : bornSection p ∈ nonnegOrthant n := by

  intro k; rw [bornSection_apply]; exact Real.sqrt_nonneg _
