-- Generated from ChapterSolovaySeparableExistence.lean — solution of BookProof.ChapterSolovaySeparableExistence.prod_disintegration
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
open BookProof.ChapterSolovaySeparableExistence



noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

set_option maxHeartbeats 1000000 in
theorem solution {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
    [StandardBorelSpace Y] [Nonempty Y] (μ : Measure (X × Y)) [IsFiniteMeasure μ] :
    ∃ κ : Kernel X Y, IsMarkovKernel κ ∧ μ.fst ⊗ₘ κ = μ := ⟨μ.condKernel, inferInstance, Measure.disintegrate μ μ.condKernel⟩
