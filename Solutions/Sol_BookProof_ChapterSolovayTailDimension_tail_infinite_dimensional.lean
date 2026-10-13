-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.tail_infinite_dimensional
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_substrate_infinite_dimensional
import Definitions.Def_PhysMeasureBasis
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal
open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution : ¬ FiniteDimensional ℝ _root_.InnerTail := substrate_infinite_dimensional
