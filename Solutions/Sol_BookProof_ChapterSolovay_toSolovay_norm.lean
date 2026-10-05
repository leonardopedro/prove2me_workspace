-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.toSolovay_norm
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ : _root_.OuterWaveFunction N headDist) :
    ‖toSolovay N headDist Ψ‖ = ‖Ψ‖ := by

  simp [toSolovay]
