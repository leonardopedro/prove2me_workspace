-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.stateMeasure_isProbability
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology
open PhysMeasureBasis

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ)
    (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure (_root_.stateMeasure N headDist) := by

  infer_instance
