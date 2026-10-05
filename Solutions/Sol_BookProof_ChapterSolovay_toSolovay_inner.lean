-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.toSolovay_inner
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ Φ : _root_.OuterWaveFunction N headDist) :
    inner ℂ (toSolovay N headDist Ψ) (toSolovay N headDist Φ) = inner ℂ Ψ Φ := by

  simp [toSolovay]
