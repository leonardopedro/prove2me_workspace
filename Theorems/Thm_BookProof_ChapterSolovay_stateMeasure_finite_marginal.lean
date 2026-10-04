-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.stateMeasure_finite_marginal
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.stateMeasure_finite_marginal (N : ℕ)
    (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] :
    Measure.map Prod.fst (_root_.stateMeasure N headDist) = headDist := by sorry
