-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.substrate_orthonormal_family
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_substrateBasisVector_orthonormal
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : ∃ e : ℕ → Substrate, Orthonormal ℝ e := ⟨substrateBasisVector, substrateBasisVector_orthonormal⟩
