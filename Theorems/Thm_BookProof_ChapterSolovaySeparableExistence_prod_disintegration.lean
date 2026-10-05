-- Generated from ChapterSolovaySeparableExistence.lean — theorem BookProof.ChapterSolovaySeparableExistence.prod_disintegration
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
open BookProof.ChapterSolovaySeparableExistence


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterSolovaySeparableExistence.prod_disintegration {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
    [StandardBorelSpace Y] [Nonempty Y] (μ : Measure (X × Y)) [IsFiniteMeasure μ] :
    ∃ κ : Kernel X Y, IsMarkovKernel κ ∧ μ.fst ⊗ₘ κ = μ := by sorry
