-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.toSolovay_inner
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.toSolovay_inner (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ Φ : _root_.OuterWaveFunction N headDist) :
    inner ℂ (toSolovay N headDist Ψ) (toSolovay N headDist Φ) = inner ℂ Ψ Φ := by sorry
