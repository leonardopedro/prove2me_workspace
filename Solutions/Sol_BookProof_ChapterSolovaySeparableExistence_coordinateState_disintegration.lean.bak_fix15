-- Generated from ChapterSolovaySeparableExistence.lean — solution of BookProof.ChapterSolovaySeparableExistence.coordinateState_disintegration
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
import Theorems.Thm_BookProof_ChapterSolovaySeparableExistence_prod_disintegration
open BookProof.ChapterSolovaySeparableExistence



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (μ : Measure (CoordinateSpace N))
    [IsFiniteMeasure μ] :
    ∃ κ : Kernel (Fin N → ℝ) CoordinateTail, IsMarkovKernel κ ∧ μ.fst ⊗ₘ κ = μ := prod_disintegration μ
