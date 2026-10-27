-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.expectation_head_decidable
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (f : _root_.InnerHead N → ℂ) (hf : AEStronglyMeasurable f headDist) :
    ∫ z : _root_.InnerSpace N, f z.1 ∂(headDist.prod _root_.tailMeasure) =
      ∫ x : _root_.InnerHead N, f x ∂headDist := by

  have h_map_fst : Measure.map Prod.fst (headDist.prod _root_.tailMeasure) = headDist := by
    rw [MeasureTheory.Measure.map_fst_prod, measure_univ, one_smul]
  rw [← integral_map (φ := Prod.fst) measurable_fst.aemeasurable (by rwa [h_map_fst]),
    h_map_fst]
