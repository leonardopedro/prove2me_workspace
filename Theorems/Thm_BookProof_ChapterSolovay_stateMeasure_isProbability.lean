-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.stateMeasure_isProbability
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.stateMeasure_isProbability (N : ℕ)
    (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure (_root_.stateMeasure N headDist) := by sorry
