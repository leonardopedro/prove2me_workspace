-- Generated from ChapterSolovaySeparableExistence.lean — theorem BookProof.ChapterSolovaySeparableExistence.exists_separable_prob_with_arbitrary_finite_law
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
open BookProof.ChapterSolovaySeparableExistence


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterSolovaySeparableExistence.exists_separable_prob_with_arbitrary_finite_law (N : ℕ)
    (headDist : Measure (Fin N → ℝ)) [IsProbabilityMeasure headDist] :
    TopologicalSpace.SeparableSpace (CoordinateSpace N) ∧
      ∃ μ : Measure (CoordinateSpace N), IsProbabilityMeasure μ ∧
        Measure.map Prod.fst μ = headDist ∧
        Measure.map Prod.snd μ = coordinateTailMeasure := by sorry
