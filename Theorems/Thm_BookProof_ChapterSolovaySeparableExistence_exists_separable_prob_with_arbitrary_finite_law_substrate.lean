-- Generated from ChapterSolovaySeparableExistence.lean — theorem BookProof.ChapterSolovaySeparableExistence.exists_separable_prob_with_arbitrary_finite_law_substrate
import Definitions.Def_ChapterSolovayCoordinates
import Mathlib
import Definitions.Def_ChapterSolovaySeparableExistence
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis
open BookProof.ChapterSolovaySeparableExistence


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterSolovayCoordinates

theorem BookProof.ChapterSolovaySeparableExistence.exists_separable_prob_with_arbitrary_finite_law_substrate (N : ℕ)
    (headDist : Measure (_root_.InnerHead N)) [IsProbabilityMeasure headDist] :
    TopologicalSpace.SeparableSpace (_root_.InnerSpace N) ∧
      ∃ μ : Measure (_root_.InnerSpace N), IsProbabilityMeasure μ ∧
        Measure.map Prod.fst μ = headDist ∧
        Measure.map Prod.snd μ = _root_.tailMeasure := by sorry
