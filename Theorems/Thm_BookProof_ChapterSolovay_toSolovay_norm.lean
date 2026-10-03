-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.toSolovay_norm
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.toSolovay_norm (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist]
    (Ψ : _root_.OuterWaveFunction N headDist) :
    ‖toSolovay N headDist Ψ‖ = ‖Ψ‖ := by sorry
