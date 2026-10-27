-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.stateMeasure_finite_marginal
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ)
    (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] :
    Measure.map Prod.fst (_root_.stateMeasure N headDist) = headDist := by

  rw [stateMeasure]
  rw [MeasureTheory.Measure.map_fst_prod, measure_univ, one_smul]
