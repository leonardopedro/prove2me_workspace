-- Generated from ChapterSolovaySeparableExistence.lean — solution of BookProof.ChapterSolovaySeparableExistence.separable_carrier_tail_infinite_dimensional
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_tail_infinite_dimensional
open BookProof.ChapterSolovaySeparableExistence



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ FiniteDimensional ℝ _root_.InnerTail := BookProof.ChapterSolovayTailDimension.tail_infinite_dimensional
