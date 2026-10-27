-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.substrateBasisVector_orthonormal
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_substrateIntervals_disjoint
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_norm_substrateBasisVector
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : Orthonormal ℝ substrateBasisVector := by

  rw [orthonormal_iff_ite]
  intro m n
  by_cases h : m = n
  · subst h
    rw [real_inner_self_eq_norm_sq, norm_substrateBasisVector]
    norm_num
  · simp only [if_neg h]
    rw [substrateBasisVector, substrateBasisVector,
      L2.inner_indicatorConstLp_indicatorConstLp, substrateIntervals_disjoint h,
      measureReal_empty, zero_smul]
