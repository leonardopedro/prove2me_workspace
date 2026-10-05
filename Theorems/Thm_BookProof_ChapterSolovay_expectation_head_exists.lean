-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.expectation_head_exists
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.expectation_head_exists (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (f : _root_.InnerHead N → ℂ) :
    ∃ (c : ℂ), ∫ x : _root_.InnerHead N, f x ∂headDist = c := by sorry
