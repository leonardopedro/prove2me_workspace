-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.expectation_head_exists
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (f : _root_.InnerHead N → ℂ) :
    ∃ (c : ℂ), ∫ x : _root_.InnerHead N, f x ∂headDist = c := ⟨_, rfl⟩
