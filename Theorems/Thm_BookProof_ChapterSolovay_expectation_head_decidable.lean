-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.expectation_head_decidable
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.expectation_head_decidable (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (f : _root_.InnerHead N → ℂ) (hf : AEStronglyMeasurable f headDist) :
    ∫ z : _root_.InnerSpace N, f z.1 ∂(headDist.prod _root_.tailMeasure) =
      ∫ x : _root_.InnerHead N, f x ∂headDist := by sorry
