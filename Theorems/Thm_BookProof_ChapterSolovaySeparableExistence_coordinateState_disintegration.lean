-- Generated from ChapterSolovaySeparableExistence.lean — theorem BookProof.ChapterSolovaySeparableExistence.coordinateState_disintegration
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
open BookProof.ChapterSolovaySeparableExistence


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterSolovaySeparableExistence.coordinateState_disintegration (N : ℕ) (μ : Measure (CoordinateSpace N))
    [IsFiniteMeasure μ] :
    ∃ κ : Kernel (Fin N → ℝ) CoordinateTail, IsMarkovKernel κ ∧ μ.fst ⊗ₘ κ = μ := by sorry
