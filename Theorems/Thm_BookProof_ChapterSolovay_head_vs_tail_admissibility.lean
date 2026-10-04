-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.head_vs_tail_admissibility
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.head_vs_tail_admissibility (N : ℕ)
    (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure (_root_.stateMeasure N headDist) ∧
      TailPriorAdmissible _root_.tailMeasure := by sorry
